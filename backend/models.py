from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import ForeignKey, Integer, CheckConstraint
from sqlalchemy.orm import relationship

db = SQLAlchemy()

# User Model
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False)
    profile_picture = db.Column(db.String(255), nullable=True)

    def to_dict(self):
        return {"id": self.id, "name": self.name, "profile_picture": self.profile_picture}

# FeedPost Model
class FeedPost(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(100), nullable=False)
    activity = db.Column(db.String(255), nullable=False)
    streak = db.Column(db.Integer, nullable=False, default=0)
    profile_picture = db.Column(db.String(255), nullable=True)
    activity_image = db.Column(db.String(255), nullable=True)

    def to_dict(self):
        return {
            "id": self.id,
            "username": self.username,
            "activity": self.activity,
            "streak": self.streak,
            "profile_picture": self.profile_picture,
            "activity_image": self.activity_image
        }

# Reaction Model
class Reaction(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    post_id = db.Column(db.Integer, ForeignKey('feed_post.id'), nullable=False)
    user_id = db.Column(db.Integer, ForeignKey('user.id'), nullable=False)
    emoji_id = db.Column(Integer, nullable=False)

    # Ensure emoji_id is between 0-4
    __table_args__ = (CheckConstraint('emoji_id >= 0 AND emoji_id <= 4', name='valid_emoji_id'),)

    # Relationships
    post = relationship("FeedPost", backref="reactions")
    user = relationship("User", backref="reactions")

    def to_dict(self):
        return {
            "id": self.id,
            "post_id": self.post_id,
            "user_id": self.user_id,
            "emoji_id": self.emoji_id
        }
