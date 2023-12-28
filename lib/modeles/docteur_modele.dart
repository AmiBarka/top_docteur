import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_docteur/modeles/commentaire._model.dart';
import 'package:top_docteur/modeles/specialite_model.dart';

class DocteurModel {
  final String id;
  final String nom;
  final String tel;
  final String email;
  final String image;
  final List<String> lien;
  final SpecialiteModel specialite;
  final List<CommentaireModel> commentaires;

  DocteurModel({
    required this.id,
    required this.nom,
    required this.tel,
    required this.email,
    required this.image,
    required this.lien,
    required this.specialite,
    required this.commentaires,
  });

  static Future<DocteurModel> fromFirestore(DocumentSnapshot doc) async {
    final data = doc.data() as Map<String, dynamic>;
    final specialiteRef = data['specialite'] as DocumentReference?;

    if (specialiteRef != null) {
      final specialiteSnapshot = await specialiteRef.get();

      if (specialiteSnapshot.exists) {
        final specialite = SpecialiteModel.fromFirestore(specialiteSnapshot);

        List<DocumentReference> commentaireReferences =
            List<DocumentReference>.from(data['commentaire'] ?? []);

        List<CommentaireModel> commentaires = [];

        for (DocumentReference commentaireRef in commentaireReferences) {
          DocumentSnapshot commentaireSnapshot = await commentaireRef.get();

          if (commentaireSnapshot.exists) {
            CommentaireModel commentaire =
                CommentaireModel.fromFirestore(commentaireSnapshot);
            commentaires.add(commentaire);
          } else {
            // Gérez le cas où le document commentaire n'existe pas
            print('Le document de commentaire n\'existe pas.');
          }
        }

        return DocteurModel(
          id: doc.id,
          nom: data['nom'] ?? '',
          tel: data['tel'] ?? '',
          email: data['email'] ?? '',
          image: data['image'] ?? '',
          lien: List<String>.from(data['lien'] ?? []),
          specialite: specialite,
          commentaires: commentaires,
        );
      } else {
        // Gérez le cas où le document spécialité n'existe pas
        print('Le document de spécialité n\'existe pas.');
      }
    }

    // Gérez le cas où la référence de spécialité est null
    return DocteurModel(
      id: doc.id,
      nom: data['nom'] ?? '',
      tel: data['tel'] ?? '',
      email: data['email'] ?? '',
      image: data['image'] ?? '',
      lien: List<String>.from(data['lien'] ?? []),
      specialite: SpecialiteModel(
        id: '',
        nom: '',
      ), // Remplacez par des valeurs par défaut
      commentaires: [],
    );
  }
}
