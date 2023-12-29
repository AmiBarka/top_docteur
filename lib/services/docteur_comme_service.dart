// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:top_docteur/modeles/commentaire._model.dart';
// import 'package:top_docteur/modeles/register_model.dart';
// //import 'package:top_docteur/modeles/commentaire_model.dart';

// class CommentaireService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<CommentaireModel>> getCommentairesByDocteur(
//       String docteurId) async {
//     try {
//       // Récupérer le document du docteur
//       DocumentSnapshot docteurSnapshot =
//           await _firestore.collection('docteur').doc(docteurId).get();
//       Map<String, dynamic> data =
//           docteurSnapshot.data() as Map<String, dynamic>;

//       // Vérifier si le document du docteur existe
//       if (docteurSnapshot.exists) {
//         // Récupérer la liste des ID de commentaires dans le document du docteur
//         List<dynamic> commentaireIds = data['commentaires'] ?? [];

//         // Initialiser la liste des commentaires
//         List<CommentaireModel> commentairesList = [];

//         // Parcourir la liste des ID de commentaires
//         for (dynamic commentaireId in commentaireIds) {
//           // Récupérer le document du commentaire
//           DocumentSnapshot commentaireSnapshot = await _firestore
//               .collection('commentaire')
//               .doc(commentaireId.id)
//               .get();

//           // Vérifier si le commentaire existe
//           if (commentaireSnapshot.exists) {
//             CommentaireModel commentaire =
//                 CommentaireModel.fromFirestore(commentaireSnapshot);
//             commentairesList.add(commentaire);
//           } else {
//             print('Le document de commentaire $commentaireId n\'existe pas.');
//           }
//         }

//         print(
//             'Nombre de commentaires trouvés pour le docteur $docteurId : ${commentairesList.length}');
//         print('Liste des commentaires : $commentairesList');

//         return commentairesList;
//       } else {
//         print('Le document de docteur $docteurId n\'existe pas.');
//         return [];
//       }
//     } catch (e) {
//       print('Erreur lors de la récupération des commentaires : $e');
//       return [];
//     }
//   }

//   Future<UserModel?> getUserByCommentaire(String commentaireId) async {
//     try {
//       // Retrieve the document of the comment
//       DocumentSnapshot commentaireSnapshot =
//           await _firestore.collection('commentaire').doc(commentaireId).get();

//       // Check if the comment exists
//       if (commentaireSnapshot.exists) {
//         // Retrieve the user ID from the comment document
//         String userId = commentaireSnapshot['userId'];

//         // Retrieve the document of the user
//         DocumentSnapshot userSnapshot =
//             await _firestore.collection('users').doc(userId).get();

//         // Check if the user exists
//         if (userSnapshot.exists) {
//           UserModel user = UserModel.fromFirestore(userSnapshot);
//           return user;
//         } else {
//           print('Le document de l\'utilisateur $userId n\'existe pas.');
//           return null;
//         }
//       } else {
//         print('Le document de commentaire $commentaireId n\'existe pas.');
//         return null;
//       }
//     } catch (e) {
//       print('Erreur lors de la récupération de l\'utilisateur : $e');
//       return null;
//     }
//   }
// }

//=================================================================================================================================
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:top_docteur/modeles/commentaire._model.dart';
// import 'package:top_docteur/modeles/register_model.dart';

// class CommentaireService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<CommentaireModel>> getCommentairesByDocteur(
//       String docteurId) async {
//     try {
//       DocumentSnapshot docteurSnapshot =
//           await _firestore.collection('docteur').doc(docteurId).get();
//       Map<String, dynamic> data =
//           docteurSnapshot.data() as Map<String, dynamic>;

//       if (docteurSnapshot.exists) {
//         List<dynamic> commentaireIds = data['commentaires'] ?? [];
//         List<CommentaireModel> commentairesList = [];

//         for (dynamic commentaireId in commentaireIds) {
//           DocumentSnapshot commentaireSnapshot = await _firestore
//               .collection('commentaire')
//               .doc(commentaireId.id)
//               .get();

//           if (commentaireSnapshot.exists) {
//             CommentaireModel commentaire = CommentaireModel(
//               id: commentaireSnapshot.id,
//               rating: commentaireSnapshot['rating'] ?? 0.0,
//               commentaire: commentaireSnapshot['commentaire'] ?? '',
//               users: await _getUserFromReference(commentaireSnapshot['users']),
//             );

//             commentairesList.add(commentaire);
//           } else {
//             print('Le document de commentaire $commentaireId n\'existe pas.');
//           }
//         }

//         print(
//             'Nombre de commentaires trouvés pour le docteur $docteurId : ${commentairesList.length}');
//         print('Liste des commentaires : $commentairesList');

//         return commentairesList;
//       } else {
//         print('Le document de docteur $docteurId n\'existe pas.');
//         return [];
//       }
//     } catch (e) {
//       print('Erreur lors de la récupération des commentaires : $e');
//       return [];
//     }
//   }

//   Future<UserModel> _getUserFromReference(dynamic usersReference) async {
//     if (usersReference is DocumentReference) {
//       DocumentSnapshot userSnapshot = await usersReference.get();
//       return UserModel(
//         uid: userSnapshot['uid'] ?? '',
//         nom: userSnapshot['nom'] ?? '',
//         email: userSnapshot['email'] ?? '',
//         tel: userSnapshot['tel'] ?? '',
//       );
//     } else {
//       print('Référence d\'utilisateur non valide.');
//       return UserModel(uid: '', nom: '', email: '', tel: '');
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_docteur/modeles/commentaire._model.dart';
import 'package:top_docteur/modeles/register_model.dart';

class CommentaireService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CommentaireModel>> getCommentairesByDocteur(
      String docteurId) async {
    try {
      DocumentSnapshot docteurSnapshot =
          await _firestore.collection('docteur').doc(docteurId).get();
      Map<String, dynamic> data =
          docteurSnapshot.data() as Map<String, dynamic>;

      if (docteurSnapshot.exists) {
        List<dynamic> commentaireIds = data['commentaires'] ?? [];
        List<CommentaireModel> commentairesList = [];

        for (dynamic commentaireId in commentaireIds) {
          DocumentSnapshot commentaireSnapshot = await _firestore
              .collection('commentaire')
              .doc(commentaireId.id)
              .get();

          if (commentaireSnapshot.exists) {
            print('Données du commentaire: ${commentaireSnapshot.data()}');

            dynamic usersReference = commentaireSnapshot['users'];
            print(
                'Type de la référence utilisateur: ${usersReference.runtimeType}');

            CommentaireModel commentaire = CommentaireModel(
              id: commentaireSnapshot.id,
              rating: commentaireSnapshot['rating'] ?? 0.0,
              commentaire: commentaireSnapshot['commentaire'] ?? '',
              users: await _getUserFromReference(usersReference),
            );

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

  Future<UserModel> _getUserFromReference(
      DocumentReference usersReference) async {
    try {
      DocumentSnapshot userSnapshot = await usersReference.get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          return UserModel(
            uid: userData['uid'] ?? '',
            nom: userData['nom'] ?? '',
            email: userData['email'] ?? '',
            tel: userData['tel'] ?? '',
          );
        } else {
          print(
              'Données utilisateur nulles pour la référence $usersReference.');
          return UserModel(uid: '', nom: '', email: '', tel: '');
        }
      } else {
        print('Le document utilisateur associé n\'existe pas.');
        return UserModel(uid: '', nom: '', email: '', tel: '');
      }
    } catch (e) {
      print('Erreur lors de la récupération du document utilisateur : $e');
      return UserModel(uid: '', nom: '', email: '', tel: '');
    }
  }
}
