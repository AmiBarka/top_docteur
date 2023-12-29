import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_docteur/modeles/commentaire._model.dart';

class CommentaireService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CommentaireModel>> getCommentairesByDocteur(
      String docteurId) async {
    try {
      // Récupérer le document du docteur
      DocumentSnapshot docteurSnapshot =
          await _firestore.collection('docteur').doc(docteurId).get();
      Map<String, dynamic> data =
          docteurSnapshot.data() as Map<String, dynamic>;

      // Vérifier si le document du docteur existe
      if (docteurSnapshot.exists) {
        // Récupérer la liste des ID de commentaires dans le document du docteur
        List<dynamic> commentaireIds = data['commentaires'] ?? [];

        // Initialiser la liste des commentaires
        List<CommentaireModel> commentairesList = [];

        // Parcourir la liste des ID de commentaires
        for (dynamic commentaireId in commentaireIds) {
          // Récupérer le document du commentaire
          DocumentSnapshot commentaireSnapshot = await _firestore
              .collection('commentaire')
              .doc(commentaireId.id)
              .get();

          // Vérifier si le commentaire existe
          if (commentaireSnapshot.exists) {
            CommentaireModel commentaire =
                CommentaireModel.fromFirestore(commentaireSnapshot);
            commentairesList.add(commentaire);
          } else {
            print('Le document de commentaire $commentaireId n\'existe pas.');
          }
        }

        print(
            'Nombre de commentaires trouvés pour le docteur $docteurId : ${commentairesList.length}');
        print('Liste des commentaires : $commentairesList');

        return commentairesList;
      } else {
        print('Le document de docteur $docteurId n\'existe pas.');
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération des commentaires : $e');
      return [];
    }
  }
}
