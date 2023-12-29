// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:top_docteur/modeles/commentaire._model.dart';

// class CommentaireAjout {
//   final CollectionReference commentaireCollection =
//       FirebaseFirestore.instance.collection('commentaire');
//   final CollectionReference docteurCollection =
//       FirebaseFirestore.instance.collection('docteur');

//   Future<void> ajouterCommentaireFirestore(
//       String commentaire, double rating, String docteurId) async {
//     try {
//       // Récupérez la référence du document utilisateur connecté
//       DocumentReference userRef = FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid);

//       // Ajoutez le commentaire à la collection "commentaire" avec la référence utilisateur
//       DocumentReference commentaireRef = await commentaireCollection.add({
//         'commentaire': commentaire,
//         'rating': rating,
//         'userId': userRef,
//       });

//       // Ajoutez la référence du commentaire à la liste des commentaires du médecin
//       await docteurCollection.doc(docteurId).update({
//         'commentaires': FieldValue.arrayUnion([commentaireRef]),
//       });
//     } catch (e) {
//       print('Erreur lors de l\'ajout du commentaire: $e');
//       // Gérez l'erreur en conséquence
//       rethrow;
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:top_docteur/modeles/commentaire._model.dart';

class Commentairerecuperes {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CommentaireModel>> getCommentairesUtilisateur() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uidUtilisateurConnecte = user.uid;

        QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
            .collection('commentaire')
            .where('userId', isEqualTo: uidUtilisateurConnecte)
            .get();

        List<CommentaireModel> commentaires = querySnapshot.docs
            .map((doc) => CommentaireModel.fromFirestore(doc))
            .toList();

        return commentaires;
      } else {
        print('Aucun utilisateur connecté.');
        return [];
      }
    } catch (error) {
      print('Erreur lors de la récupération des commentaires : $error');
      return [];
    }
  }
}

class CommentaireAjout {
  final CollectionReference commentaireCollection =
      FirebaseFirestore.instance.collection('commentaire');
  final CollectionReference docteurCollection =
      FirebaseFirestore.instance.collection('docteur');

  Future<void> ajouterCommentaireFirestore(
      String commentaire, double rating, String docteurId) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference commentaireRef = await commentaireCollection.add({
        'commentaire': commentaire,
        'rating': rating,
        'userId': userId,
      });

      await docteurCollection.doc(docteurId).update({
        'commentaires': FieldValue.arrayUnion([commentaireRef]),
      });
    } catch (e) {
      print('Erreur lors de l\'ajout du commentaire: $e');
      rethrow;
    }
  }
}
//=============================================
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:top_docteur/controllers/login_controller.dart';
// import 'package:top_docteur/modeles/commentaire._model.dart';

// class CommentaireAjout {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final AuthController _authController = Get.find<AuthController>();

//   Future<void> ajouterCommentaireFirestore(
//     String commentaire,
//     double rating,
//     String docteurId,
//   ) async {
//     try {
//       String userId = _authController.currentUser.value?.uid ?? '';

//       if (userId.isEmpty || docteurId.isEmpty) {
//         print('Erreur : ID de l\'utilisateur ou du docteur vide');
//         return;
//       }

//       DocumentReference<Map<String, dynamic>> docteurRef =
//           _firestore.collection('docteur').doc(docteurId);

//       DocumentReference<Map<String, dynamic>> docRef =
//           _firestore.collection('commentaire').doc();

//       await docRef.set({
//         'userId': userId,
//         'commentaire': commentaire,
//         'rating': rating,
//         'docteur': docteurRef,
//       });

//       // // Ajouter l'ID du commentaire dans la collection 'cocter'
//       // await _firestore.collection('docteur').doc(docRef.id).set({
//       //   'docteurId': docteurId,
//       //   // Ajoutez d'autres champs si nécessaire
//       // });

//       // Mettre à jour la liste de commentaires du docteur avec l'ID du commentaire
//       await docteurRef.update({
//         'commentaires': FieldValue.arrayUnion([docRef.id]),
//       });

//       // Mise à jour du modèle Docteur localement (si nécessaire)
//       await _mettreAJourDocteurLocal(docteurId, docRef.id);

//       print('Commentaire ajouté avec succès : $commentaire, Rating : $rating');
//     } catch (error) {
//       print('Erreur lors de l\'ajout du commentaire : $error');
//     }
//   }

//   Future<void> _mettreAJourDocteurLocal(
//       String docteurId, String commentaireId) async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> docteurSnapshot =
//           await _firestore.collection('docteur').doc(docteurId).get();

//       if (docteurSnapshot.exists) {
//         List<dynamic> commentaires =
//             List<dynamic>.from(docteurSnapshot.data()?['commentaires'] ?? []);
//         commentaires.add(commentaireId);

//         await _firestore.collection('docteur').doc(docteurId).update({
//           'commentaires': commentaires,
//         });

//         print('ID du commentaire ajouté à cocter avec succès: $commentaireId');
//       } else {
//         print('Le document de docteur $docteurId n\'existe pas.');
//       }
//     } catch (error) {
//       print('Erreur lors de la mise à jour du docteur : $error');
//     }
//   }
// }

//===========================================================================================

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
