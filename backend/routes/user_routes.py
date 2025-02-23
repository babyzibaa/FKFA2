from flask import Blueprint, request, jsonify, current_app
from werkzeug.utils import secure_filename
import os
from models import db, User

user_routes = Blueprint('user_routes', __name__)

ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "gif"}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# CREATE a new user
@user_routes.route('/users', methods=['POST'])
def create_user():
    data = request.form  # Using form-data for profile picture upload support
    name = data.get("name")
    email = data.get("email")
    password = data.get("password")  # No hashing yet

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
            profile_picture = filename

    new_user = User(name=name, email=email, password=password, profile_picture=profile_picture)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "User created successfully", "user": new_user.to_dict()}), 201

# GET all users
@user_routes.route('/users', methods=['GET'])
def get_users():
    users = User.query.all()
    return jsonify([user.to_dict() for user in users])

# GET a specific user by ID
@user_routes.route('/users/<int:user_id>', methods=['GET'])
def get_user(user_id):
    user = User.query.get_or_404(user_id)
    return jsonify(user.to_dict())

# UPDATE user details (excluding password)
@user_routes.route('/users/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    user = User.query.get_or_404(user_id)
    data = request.json

    user.name = data.get("name", user.name)
    user.email = data.get("email", user.email)

    db.session.commit()

    return jsonify({"message": "User updated successfully", "user": user.to_dict()})

# UPDATE user profile picture
@user_routes.route('/users/<int:user_id>/profile_picture', methods=['PUT'])
def update_profile_picture(user_id):
    user = User.query.get_or_404(user_id)

    if "profile_picture" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files["profile_picture"]
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(current_app.config["UPLOAD_FOLDER"], filename)
        file.save(filepath)  # Save image to static/uploads/

        user.profile_picture = filename  # Store only filename in DB
        db.session.commit()

        return jsonify({"message": "Profile picture updated", "user": user.to_dict()}), 200

    return jsonify({"error": "Invalid file type"}), 400


# DELETE a user by ID
@user_routes.route('/users/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    user = User.query.get_or_404(user_id)
    db.session.delete(user)
    db.session.commit()
    return jsonify({"message": "User deleted successfully"})
