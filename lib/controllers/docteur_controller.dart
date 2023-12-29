import 'package:get/get.dart';
import 'package:top_docteur/modeles/commentaire._model.dart';
import 'package:top_docteur/modeles/docteur_modele.dart';
//import 'package:top_docteur/modeles/register_model.dart';
import 'package:top_docteur/services/docteur_comme_service.dart';
import 'package:top_docteur/services/docteur_service.dart';
//import 'package:top_docteur/services/specialite_service.dart';

class DocteurController extends GetxController {
  final SpecialiteService _specialiteService = SpecialiteService();
  RxList<DocteurModel> docteurs = <DocteurModel>[].obs;

  Future<void> getDocteursBySpecialite(String specialiteNom) async {
    try {
      var docteursList =
          await _specialiteService.getDocteursBySpecialite(specialiteNom);
      docteurs.assignAll(docteursList);
    } catch (e) {
      print('Erreur lors de la récupération des docteurs : $e');
    }
  }
}

//========================================================================================
class DetailsController {
  final DocteurModel docteur;
  final SpecialiteService specialiteService;
  final CommentaireService commentaireService;

  DetailsController({
    required this.docteur,
    required this.specialiteService,
    required this.commentaireService,
  });

  Future<List<CommentaireModel>> getCommentaires() async {
    return await commentaireService.getCommentairesByDocteur(docteur.id);
  }

  Future<List<DocteurModel>> getDocteursBySpecialite() async {
    return await specialiteService
        .getDocteursBySpecialite(docteur.specialite.nom);
  }
}

// class DetailsController {
//   final DocteurModel docteur;
//   final SpecialiteService specialiteService;
//   final CommentaireService commentaireService;

//   DetailsController({
//     required this.docteur,
//     required this.specialiteService,
//     required this.commentaireService,
//   });

//   Future<List<CommentaireModel>> getCommentaires() async {
//     List<CommentaireModel> commentairesList =
//         await commentaireService.getCommentairesByDocteur(docteur.id);

//     // Iterate through the comments and retrieve the user for each comment
//     for (int i = 0; i < commentairesList.length; i++) {
//       CommentaireModel commentaire = commentairesList[i];
//       UserModel? user =
//           await commentaireService.getUserByCommentaire(commentaire.id);

//       // Assign the user to the comment if it exists
//       if (user != null) {
//         commentairesList[i] = CommentaireModel(
//           id: commentaire.id,
//           rating: commentaire.rating,
//           commentaire: commentaire.commentaire,
//           users: user,
//         );
//       }
//     }

//     return commentairesList;
//   }

//   Future<List<DocteurModel>> getDocteursBySpecialite() async {
//     return await specialiteService
//         .getDocteursBySpecialite(docteur.specialite.nom);
//   }
// }
