import 'package:flutter/material.dart';
import 'package:top_docteur/modeles/commentaire._model.dart';
import 'package:top_docteur/modeles/docteur_modele.dart';

class DetailsPage extends StatelessWidget {
  final DocteurModel docteur;

  DetailsPage({Key? key, required this.docteur}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Informations du Docteur : $docteur');

    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Docteur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 150.0,
                height: 150.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    docteur.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Nom: ${docteur.nom}', style: TextStyle(fontSize: 18.0)),
            Text('Email: ${docteur.email}', style: TextStyle(fontSize: 16.0)),
            Text('Téléphone: ${docteur.tel}', style: TextStyle(fontSize: 16.0)),
            Text('Liens: ${docteur.lien.join(', ')}',
                style: TextStyle(fontSize: 16.0)),
            Text('Rating total: ${_calculateTotalRating(docteur.commentaires)}',
                style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 16.0),
            Text('Commentaires:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: docteur.commentaires.length,
                itemBuilder: (context, index) {
                  var commentaire = docteur.commentaires[index];
                  return ListTile(
                    title: Text(commentaire.commentaire),
                    subtitle: Text('Rating: ${commentaire.rating}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalRating(List<CommentaireModel> commentaires) {
    if (commentaires.isEmpty) {
      return 0.0;
    }

    double totalRating = 0.0;
    for (var commentaire in commentaires) {
      totalRating += commentaire.rating;
      print(
          'Commentaire: ${commentaire.commentaire}, Rating: ${commentaire.rating}');
    }

    return totalRating / commentaires.length;
  }
}
