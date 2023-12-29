import 'package:flutter/material.dart';

import 'package:top_docteur/modeles/commentaire._model.dart';
import 'package:top_docteur/services/ajoute%20commantaire.dart';

class CommentairesPage extends StatefulWidget {
  @override
  _CommentairesPageState createState() => _CommentairesPageState();
}

class _CommentairesPageState extends State<CommentairesPage> {
  final Commentairerecupere _commentaireService = Commentairerecupere();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Commentaires'),
      ),
      body: FutureBuilder<List<CommentaireModel>>(
        future: _commentaireService.getCommentairesUtilisateur(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            List<CommentaireModel> commentaires = snapshot.data ?? [];
            return _buildCommentairesList(commentaires);
          }
        },
      ),
    );
  }

  Widget _buildCommentairesList(List<CommentaireModel> commentaires) {
    return ListView.builder(
      itemCount: commentaires.length,
      itemBuilder: (context, index) {
        CommentaireModel commentaire = commentaires[index];
        return Card(
          elevation: 4.0,
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Commentaire: ${commentaire.commentaire}'),
                Text('Rating: ${commentaire.rating}'),
                // Ajoutez d'autres informations du commentaire si nécessaire
              ],
            ),
          ),
        );
      },
    );
  }
}
