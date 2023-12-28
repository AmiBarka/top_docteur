// CommentaireModel
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_docteur/modeles/register_model.dart';

class CommentaireModel {
  final String id;
  final double rating;
  final String commentaire;
  final UserModel users;

  CommentaireModel({
    required this.id,
    required this.rating,
    required this.commentaire,
    required this.users,
  });

  static CommentaireModel fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CommentaireModel(
      id: doc.id,
      rating: data['rating'] ?? 0.0,
      commentaire: data['commentaire'] ?? '',
      users: UserModel.fromFirestore(
          data['users']), // Assurez-vous que cela est correct
    );
  }
}
