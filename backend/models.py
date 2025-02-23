from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import ForeignKey, Integer, CheckConstraint
from sqlalchemy.orm import relationship

db = SQLAlchemy()


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)
    profile_picture = db.Column(db.String(255), nullable=True)  # Stores filename

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "email": self.email,
            "profile_picture": f"/uploads/{self.profile_picture}" if self.profile_picture else None
        }

class FeedPost(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id = db.Column(db.Integer, ForeignKey('user.id'), nullable=False)
    username = db.Column(db.String(100), nullable=False)
    activity = db.Column(db.String(255), nullable=False)
    streak = db.Column(db.Integer, nullable=False, default=0)
    profile_picture = db.Column(db.String(255), nullable=True)  # Only stores filename
    activity_image = db.Column(db.String(255), nullable=True)   # Only stores filename

    user = relationship("User", backref="posts")

    def to_dict(self):
        return {
            "id": self.id,
            "user_id": self.user_id,
            "username": self.username,
            "activity": self.activity,
            "streak": self.streak,
            "profile_picture": f"/static/uploads/{self.profile_picture}" if self.profile_picture else None,
            "activity_image": f"/static/uploads/{self.activity_image}" if self.activity_image else None
        }


class Reaction(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    post_id = db.Column(db.Integer, ForeignKey('feed_post.id'), nullable=False)
    user_id = db.Column(db.Integer, ForeignKey('user.id'), nullable=False)
    emoji_id = db.Column(Integer, nullable=False)

    __table_args__ = (CheckConstraint('emoji_id >= 0 AND emoji_id <= 4', name='valid_emoji_id'),)

    post = relationship("FeedPost", backref="reactions")
    user = relationship("User", backref="reactions")

    def to_dict(self):
        return {
            "id": self.id,
            "post_id": self.post_id,
            "user_id": self.user_id,
            "emoji_id": self.emoji_id
        }
