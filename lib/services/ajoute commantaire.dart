import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:top_docteur/modeles/commentaire._model.dart';

class CommentaireAjout {
  final CollectionReference commentaireCollection =
      FirebaseFirestore.instance.collection('commentaire');
  final CollectionReference docteurCollection =
      FirebaseFirestore.instance.collection('docteur');

  Future<void> ajouterCommentaireFirestore(
      String commentaire, double rating, String docteurId) async {
    try {
      // Récupérez la référence du document utilisateur connecté
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      // Ajoutez le commentaire à la collection "commentaire" avec la référence utilisateur
      DocumentReference commentaireRef = await commentaireCollection.add({
        'commentaire': commentaire,
        'rating': rating,
        'userId': userRef,
      });

      // Ajoutez la référence du commentaire à la liste des commentaires du médecin
      await docteurCollection.doc(docteurId).update({
        'commentaires': FieldValue.arrayUnion([commentaireRef]),
      });
    } catch (e) {
      print('Erreur lors de l\'ajout du commentaire: $e');
      // Gérez l'erreur en conséquence
      rethrow;
    }
  }
}

//===========================================================
class Commentairerecupere {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final AuthController _authController = Get.put(AuthController());

  Future<List<CommentaireModel>> getCommentairesUtilisateur() async {
    try {
      // Récupérer l'objet utilisateur connecté depuis FirebaseAuth
      User? user = FirebaseAuth.instance.currentUser;

      // Vérifier si l'utilisateur est connecté
      if (user != null) {
        String uidUtilisateurConnecte = user.uid;

        // Effectuer une requête pour récupérer les commentaires de l'utilisateur
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
            .collection('commentaires')
            .where('userId', isEqualTo: uidUtilisateurConnecte)
            .get();

        // Mapper les documents en objets CommentaireModel
        List<CommentaireModel> commentaires = querySnapshot.docs
            .map((doc) => CommentaireModel.fromFirestore(doc))
            .toList();

        return commentaires;
      } else {
        // Aucun utilisateur connecté, renvoyer une liste vide
        print('Aucun utilisateur connecté.');
        return [];
      }
    } catch (error) {
      // Gérer les erreurs ici
      print('Erreur lors de la récupération des commentaires : $error');
      return [];
    }
  }
}
