from flask import Blueprint, request, jsonify
from sqlalchemy.orm import joinedload
from models import db, FeedPost, Reaction

feed_routes = Blueprint('feed_routes', __name__)

# GET: Fetch all posts with reactions (no counters, just raw reaction data)
@feed_routes.route('/feeds', methods=['GET', 'POST'])
def get_feed_posts():
    if request.method == 'POST':
        post = FeedPost(**request.get_json())
        db.session.add(post)
        db.session.commit()
        return jsonify(post.to_dict())

    posts = FeedPost.query.options(joinedload(FeedPost.reactions)).all()
    response = []
    for post in posts:
        response.append({
            "id": post.id,
            "username": post.username,
            "activity": post.activity,
            "streak": post.streak,
            "profile_picture": post.profile_picture,
            "activity_image": post.activity_image,
        })

    return jsonify(response)


@feed_routes.route('/feeds/<int:post_id>', methods=['GET'])
def get_feed_post_detail(post_id):
    post = FeedPost.query.first_or_404(post_id)
    return jsonify(post.to_dict())

@feed_routes.route('/feeds/<int:post_id>/reactions', methods=['GET', "POST"])
def get_feed_post_detail_reactions(post_id):
    if request.method == "GET":
        reactions = Reaction.query.where(Reaction.post_id == post_id).all()
        return jsonify([r.to_dict() for r in reactions])
    elif request.method == "POST":
        request_json = request.get_json(force=True)
        reaction = Reaction(post_id=post_id, emoji_id=request_json['emoji_id'], user_id=0)
        db.session.add(reaction)
        db.session.commit()
        return jsonify(reaction.to_dict())