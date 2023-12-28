import 'package:get/get.dart';
import 'package:top_docteur/modeles/docteur_modele.dart';
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
