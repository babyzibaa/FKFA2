from flask import Blueprint, request, jsonify
from models import db, User

auth_routes = Blueprint('auth_routes', __name__)

# REGISTER: Create a new user (No Hashing)
@auth_routes.route('/register', methods=['POST'])
def register():
    data = request.json
    name = data.get("name")
    email = data.get("email")
    password = data.get("password")

    if not name or not email or not password:
        return jsonify({"error": "All fields are required"}), 400

    # Check if user already exists
    if User.query.filter_by(email=email).first():
        return jsonify({"error": "Email already registered"}), 400

    new_user = User(name=name, email=email, password=password)  # Storing plain-text password
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "User registered successfully", "user": new_user.to_dict()}), 201

# LOGIN: Authenticate user (No Hashing)
@auth_routes.route('/login', methods=['POST'])
def login():
    data = request.json
    email = data.get("email")
    password = data.get("password")

    user = User.query.filter_by(email=email, password=password).first()
    if not user:
        return jsonify({"error": "Invalid email or password"}), 401

    return jsonify({"message": "Login successful", "user": user.to_dict()})
