from flask import Flask, jsonify
import os
from models import db
from routes.user_routes import user_routes
from routes.feed_routes import feed_routes
from routes.reaction_routes import reaction_routes

app = Flask(__name__)

# Ensure the instance folder exists
if not os.path.exists("instance"):
    os.makedirs("instance")

# Use SQLite in instance folder
BASE_DIR = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = f'sqlite:///{os.path.join(BASE_DIR, "instance", "app.db")}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

# Register Blueprints
app.register_blueprint(user_routes)
app.register_blueprint(feed_routes)
app.register_blueprint(reaction_routes)

import traceback

@app.errorhandler(500)
def internal_server_error(e):
    print(traceback.format_exc())  # This will print the full error log
    return jsonify({"error": "Internal Server Error", "details": str(e)}), 500


# Create tables
with app.app_context():
    db.create_all()

if __name__ == '__main__':
    app.run(debug=True)
