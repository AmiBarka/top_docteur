///===================================================================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_docteur/modeles/commentaire._model.dart';
import 'package:top_docteur/modeles/docteur_modele.dart';
//import 'package:top_docteur/modeles/register_model.dart';
import 'package:top_docteur/modeles/specialite_model.dart';
import 'package:top_docteur/services/docteur_comme_service.dart';
//import 'commentaire_service.dart'; // Importez votre service de commentaires

class SpecialiteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocteurModel>> getDocteursBySpecialite(
      String specialiteNom) async {
    try {
      QuerySnapshot specialiteQuerySnapshot = await _firestore
          .collection('specialite')
          .where('nom', isEqualTo: specialiteNom)
          .get();

      if (specialiteQuerySnapshot.docs.isEmpty) {
        print('Spécialité non trouvée');
        return [];
      }

      String specialiteId = specialiteQuerySnapshot.docs.first.id;

      QuerySnapshot querySnapshot = await _firestore
          .collection('docteur')
          .where('specialite',
              isEqualTo: _firestore.doc('specialite/$specialiteId'))
          .get();

      print(
          'Nombre de docteurs trouvés pour $specialiteNom : ${querySnapshot.size}');

      List<DocteurModel> docteursList = [];

      // Utilisez votre service CommentaireService pour récupérer les commentaires
      CommentaireService commentaireService = CommentaireService();

      for (QueryDocumentSnapshot<Object?> doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        DocumentSnapshot<Object?> specialiteSnapshot =
            await data['specialite'].get();

        SpecialiteModel specialite =
            SpecialiteModel.fromFirestore(specialiteSnapshot);

        // Récupérer les commentaires associés à ce médecin en utilisant CommentaireService
        List<CommentaireModel> commentairesList =
            await commentaireService.getCommentairesByDocteur(doc.id);

        docteursList.add(DocteurModel(
          id: doc.id,
          nom: data['nom'] ?? '',
          tel: data['tel'] ?? '',
          email: data['email'] ?? '',
          image: data['image'] ?? '',
          lien: List<String>.from(data['lien'] ?? []),
          specialite: specialite,
          commentaires: commentairesList,
        ));
      }

      return docteursList;
    } catch (e) {
      print('Erreur lors de la récupération des docteurs : $e');
      return [];
    }
  }
}
