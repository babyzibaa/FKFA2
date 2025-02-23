from flask import Blueprint, request, jsonify, current_app
from werkzeug.utils import secure_filename
import os
from models import db, User

user_routes = Blueprint('user_routes', __name__)

ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "gif"}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@user_routes.route('/register', methods=['POST'])
def register_user():
    data = request.form
    name = data.get("name")
    email = data.get("email")
    password = data.get("password")

    if not name or not email or not password:
        return jsonify({"error": "All fields are required"}), 400

    if User.query.filter_by(email=email).first():
        return jsonify({"error": "Email already registered"}), 400

    profile_picture = None
    if "profile_picture" in request.files:
        file = request.files["profile_picture"]
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(current_app.config["UPLOAD_FOLDER"], filename))
            profile_picture = filename  # Save only filename in DB

    new_user = User(name=name, email=email, password=password, profile_picture=profile_picture)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "User registered successfully", "user": new_user.to_dict()}), 201

@user_routes.route('/users/<int:user_id>/profile_picture', methods=['PUT'])
def update_profile_picture(user_id):
    user = User.query.get_or_404(user_id)

    if "profile_picture" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files["profile_picture"]
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(current_app.config["UPLOAD_FOLDER"], filename))
        user.profile_picture = filename
        db.session.commit()
        return jsonify({"message": "Profile picture updated", "user": user.to_dict()}), 200

    return jsonify({"error": "Invalid file type"}), 400
