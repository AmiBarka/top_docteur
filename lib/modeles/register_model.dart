import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String nom;
  final String email;
  final String tel;

  UserModel({
    required this.uid,
    required this.nom,
    required this.email,
    required this.tel,
  });

  // Ajoutez cette méthode pour créer une instance de UserModel à partir d'un DocumentSnapshot
  static UserModel fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'] ?? '', // Assurez-vous que le champ 'uid' est correct
      nom: data['nom'] ?? '',
      email: data['email'] ?? '',
      tel: data['tel'] ?? '',
    );
  }
}
