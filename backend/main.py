from flask import Flask, send_from_directory, jsonify
import os
from models import db
from routes.auth_routes import auth_routes
from routes.user_routes import user_routes
from routes.feed_routes import feed_routes
from routes.reaction_routes import reaction_routes
import traceback

app = Flask(__name__)

# Ensure necessary folders exist
if not os.path.exists("instance"):
    os.makedirs("instance")

UPLOAD_FOLDER = os.path.join("static", "uploads")
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER

# Ensure absolute path for SQLite database
BASE_DIR = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = f'sqlite:///{os.path.join(BASE_DIR, "instance", "app.db")}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

# Register Blueprints
app.register_blueprint(user_routes)
app.register_blueprint(feed_routes)
app.register_blueprint(reaction_routes)
app.register_blueprint(auth_routes, url_prefix='/auth')

# Error Handler for 500 Internal Server Error
@app.errorhandler(500)
def internal_server_error(e):
    print(traceback.format_exc())
    return jsonify({"error": "Internal Server Error", "details": str(e)}), 500

# Serve uploaded images
@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config["UPLOAD_FOLDER"], filename)

# Create database tables
with app.app_context():
    db.create_all()

if __name__ == '__main__':
    app.run(debug=True)
