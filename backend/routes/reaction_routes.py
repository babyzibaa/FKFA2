from flask import Blueprint, request, jsonify
from models import db, Reaction, User, FeedPost

reaction_routes = Blueprint('reaction_routes', __name__)

# CREATE: Add a reaction with emojiId
@reaction_routes.route('/reactions', methods=['POST'])
def create_reaction():
    data = request.json

    # Validate post & user exist
    post = FeedPost.query.get(data.get('post_id'))
    user = User.query.get(data.get('user_id'))
    if not post or not user:
        return jsonify({"error": "Post or User not found"}), 404

    # Validate emojiId range (0-4)
    if data.get('emoji_id') not in [0, 1, 2, 3, 4]:
        return jsonify({"error": "Invalid emojiId. Must be between 0-4"}), 400

    new_reaction = Reaction(
        post_id=data['post_id'],
        user_id=data['user_id'],
        emoji_id=data['emoji_id']
    )
    db.session.add(new_reaction)
    db.session.commit()
    return jsonify({"message": "Reaction added", "reaction": new_reaction.to_dict()}), 201

# DELETE: Remove a reaction
@reaction_routes.route('/reactions/<int:reaction_id>', methods=['DELETE'])
def delete_reaction(reaction_id):
    reaction = Reaction.query.get_or_404(reaction_id)
    db.session.delete(reaction)
    db.session.commit()
    return jsonify({"message": "Reaction deleted"})
