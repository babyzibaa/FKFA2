from flask import Blueprint, request, jsonify, current_app
from werkzeug.utils import secure_filename
import os
from models import db, FeedPost

feed_routes = Blueprint('feed_routes', __name__)

ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "gif"}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@feed_routes.route('/feeds', methods=['POST'])
def create_feed_post():
    data = request.form
    username = data.get("username")
    activity = data.get("activity")
    streak = data.get("streak", 0)

    activity_image = None
    if "activity_image" in request.files:
        file = request.files["activity_image"]
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(current_app.config["UPLOAD_FOLDER"], filename))
            activity_image = filename

    new_post = FeedPost(username=username, activity=activity, streak=streak, activity_image=activity_image)
    db.session.add(new_post)
    db.session.commit()

    return jsonify({"message": "Post created", "post": new_post.to_dict()}), 201
