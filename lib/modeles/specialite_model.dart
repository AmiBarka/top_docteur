import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialiteModel {
  final String id;
  final String nom;

  SpecialiteModel({required this.id, required this.nom});

  factory SpecialiteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SpecialiteModel(id: doc.id, nom: data['nom'] ?? '');
  }
}
