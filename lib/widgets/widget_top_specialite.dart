import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_docteur/controllers/docteur_controller.dart';
import 'package:top_docteur/modeles/commentaire._model.dart';
import 'package:top_docteur/screens/specialiter/detailler.dart';

class DocteurWidget extends StatelessWidget {
  final DocteurController _controller = Get.put(DocteurController());

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              //_controller.searchDoctorsByName(value);
            },
            decoration: InputDecoration(
              hintText: 'Rechercher par nom...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            if (_controller.docteurs.isEmpty) {
              return Center(
                child: Text('Aucun docteur trouvé'),
              );
            } else {
              return ListView.builder(
                itemCount: _controller.docteurs.length,
                itemBuilder: (context, index) {
                  var docteur = _controller.docteurs[index];

                  return InkWell(
                    onTap: () {
                      Get.to(() => DetailsPage(docteur: docteur));
                    },
                    child: Card(
                      margin: EdgeInsets.all(30.0),
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.grey[100],
                      child: ListTile(
                        title: Text(
                          docteur.nom,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              docteur.email,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Spécialité: ${docteur.specialite.nom}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Rating: ${_calculateRating(docteur.commentaires)}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.all(20.0),
                        leading: SizedBox(
                          width: 60.0,
                          height: 1000.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.0),
                            child: Image.network(
                              docteur.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ],
    );
  }

  double _calculateRating(List<CommentaireModel> commentaires) {
    if (commentaires.isEmpty) {
      return 0.0;
    }

    double totalRating = 0.0;
    for (var commentaire in commentaires) {
      totalRating += commentaire.rating;
    }

    return totalRating / commentaires.length;
  }
}
