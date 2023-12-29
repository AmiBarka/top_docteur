// import 'package:flutter/material.dart';
// import 'package:top_docteur/controllers/docteur_controller.dart';
// import 'package:top_docteur/modeles/commentaire._model.dart';
// import 'package:top_docteur/modeles/docteur_modele.dart';
// import 'package:top_docteur/services/docteur_comme_service.dart';
// import 'package:top_docteur/services/docteur_service.dart';
// //import 'details_controller.dart';

// class DetailsPage extends StatefulWidget {
//   final DocteurModel docteur;

//   DetailsPage({Key? key, required this.docteur}) : super(key: key);

//   @override
//   _DetailsPageState createState() => _DetailsPageState();
// }

// class _DetailsPageState extends State<DetailsPage> {
//   late DetailsController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = DetailsController(
//       docteur: widget.docteur,
//       specialiteService: SpecialiteService(),
//       commentaireService: CommentaireService(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FutureBuilder<List<CommentaireModel>>(
//           future: _controller.getCommentaires(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Erreur: ${snapshot.error}');
//             } else {
//               return _buildDetailsPage(snapshot.data ?? []);
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailsPage(List<CommentaireModel> commentaires) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Détails du Docteur'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: SizedBox(
//                 width: 150.0,
//                 height: 150.0,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: Image.network(
//                     widget.docteur.image,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Text('Nom: ${widget.docteur.nom}',
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
//             Text('Email: ${widget.docteur.email}'),
//             Text('Téléphone: ${widget.docteur.tel}'),
//             Text('Lien: ${widget.docteur.lien.join(', ')}'),
//             Text('Spécialité: ${widget.docteur.specialite.nom}'),
//             SizedBox(height: 16.0),
//             Text('Commentaires:',
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8.0),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: commentaires.length,
//                 itemBuilder: (context, index) {
//                   var commentaire = commentaires[index];
//                   return ListTile(
//                     title: Text(commentaire.commentaire),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Rating: ${commentaire.rating}'),
//                         Text('Nom de l\'utilisateur: ${commentaire.users.nom}'),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:top_docteur/controllers/docteur_controller.dart';
import 'package:top_docteur/modeles/commentaire._model.dart';
import 'package:top_docteur/modeles/docteur_modele.dart';
import 'package:top_docteur/services/ajoute%20commantaire.dart';
import 'package:top_docteur/services/ajoute%20commantaire.dart';
import 'package:top_docteur/services/docteur_comme_service.dart';
import 'package:top_docteur/services/docteur_service.dart';

class DetailsPage extends StatefulWidget {
  final DocteurModel docteur;

  DetailsPage({Key? key, required this.docteur}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late DetailsController _controller;
  final TextEditingController commentaireController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = DetailsController(
      docteur: widget.docteur,
      specialiteService: SpecialiteService(),
      commentaireService: CommentaireService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Docteur'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      widget.docteur.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nom: ${widget.docteur.nom}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Email: ${widget.docteur.email}'),
                      Text('Téléphone: ${widget.docteur.tel}'),
                      Text('Lien: ${widget.docteur.lien.join(', ')}'),
                      Text('Spécialité: ${widget.docteur.specialite.nom}'),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.message),
                            onPressed: () {
                              _showCommentairesModal(context);
                            },
                          ),
                          Text('Voir les commentaires'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              _buildAjouterCommentaireForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentairesList(List<CommentaireModel> commentaires) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var commentaire in commentaires)
          ListTile(
            title: Text(commentaire.commentaire),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rating: ${commentaire.rating}'),
                Text('Nom de l\'utilisateur: ${commentaire.users.nom}'),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAjouterCommentaireForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ajouter un commentaire',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: commentaireController,
            decoration: InputDecoration(
              labelText: 'Commentaire',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: noteController,
            decoration: InputDecoration(
              labelText: 'Rating',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              String commentaire = commentaireController.text;
              double rating = double.parse(noteController.text);

              // Appeler la fonction pour ajouter le commentaire directement
              await CommentaireAjout().ajouterCommentaireFirestore(
                commentaire,
                rating,
                widget.docteur.id,
              );

              // Afficher un message en fonction du succès ou de l'échec de l'ajout
              // (mettez à jour ce code en conséquence)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Commentaire ajouté avec succès!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Envoyer'),
          ),
        ],
      ),
    );
  }

  void _showCommentairesModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Commentaires'),
          content: FutureBuilder<List<CommentaireModel>>(
            future: _controller.getCommentaires(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur: ${snapshot.error}');
              } else {
                return _buildCommentairesList(snapshot.data ?? []);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}
