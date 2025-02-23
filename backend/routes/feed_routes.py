from flask import Blueprint, request, jsonify, current_app
from werkzeug.utils import secure_filename
import os
from sqlalchemy.orm import joinedload
from models import db, FeedPost, Reaction

feed_routes = Blueprint('feed_routes', __name__)

ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "gif"}


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


from flask import Blueprint, request, jsonify, current_app
from werkzeug.utils import secure_filename
import os
from sqlalchemy.orm import joinedload
from models import db, FeedPost, User, Reaction

feed_routes = Blueprint('feed_routes', __name__)

ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "gif"}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# CREATE a new feed post (with user's profile picture and activity image)
@feed_routes.route('/feeds', methods=['POST'])
def create_feed_post():
    data = request.get_json()  # Get form data
    user_id = data.get("user_id")
    activity = data.get("activity")
    streak = data.get("streak", 0)

    if not user_id or not activity:
        return jsonify({"error": "User ID and activity are required"}), 400

    user = User.query.get(user_id)
    if not user:
        return jsonify({"error": "User not found"}), 404

    # Fetch user's profile picture from the User table
    profile_picture = user.profile_picture

    activity_image = None
    if "activity_image" in request.files:
        file = request.files["activity_image"]
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            filepath = os.path.join(current_app.config["UPLOAD_FOLDER"], filename)
            file.save(filepath)  # Save image to static/uploads/
            activity_image = filename

    new_post = FeedPost(
        user_id=user.id,
        username=user.name,
        activity=activity,
        streak=streak,
        profile_picture=profile_picture,  # Automatically fetched
        activity_image=activity_image  # Stores only filename
    )

    db.session.add(new_post)
    db.session.commit()

    return jsonify({"message": "Post created", "post": new_post.to_dict()}), 201

# GET all feed posts (includes full URLs for images)
@feed_routes.route('/feeds', methods=['GET'])
def get_feed_posts():
    posts = FeedPost.query.options(joinedload(FeedPost.reactions)).all()
    return jsonify([post.to_dict() for post in posts])


# GET a single feed post by ID
@feed_routes.route('/feeds/<int:post_id>', methods=['GET'])
def get_feed_post_detail(post_id):
    post = FeedPost.query.options(joinedload(FeedPost.reactions)).filter_by(id=post_id).first_or_404()

    return jsonify({
        "id": post.id,
        "username": post.username,
        "activity": post.activity,
        "streak": post.streak,
        "profile_picture": post.profile_picture,
        "activity_image": f"/uploads/{post.activity_image}" if post.activity_image else None,
        "reactions": [reaction.to_dict() for reaction in post.reactions]
    })


# GET all reactions for a specific post
@feed_routes.route('/feeds/<int:post_id>/reactions', methods=['GET'])
def get_feed_post_reactions(post_id):
    reactions = Reaction.query.filter_by(post_id=post_id).all()
    return jsonify([reaction.to_dict() for reaction in reactions])


# DELETE a feed post by ID
@feed_routes.route('/feeds/<int:post_id>', methods=['DELETE'])
def delete_feed_post(post_id):
    post = FeedPost.query.get_or_404(post_id)
    db.session.delete(post)
    db.session.commit()
    return jsonify({"message": "Post deleted"})
