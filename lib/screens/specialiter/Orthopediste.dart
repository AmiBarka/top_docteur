import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_docteur/controllers/docteur_controller.dart';
//import 'package:top_docteur/widgets/docteur_widget.dart';
import 'package:top_docteur/widgets/widget_top_specialite.dart';

class DocteurPage extends StatelessWidget {
  final DocteurController _controller = Get.put(DocteurController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              'Liste Orthopédiste',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: _controller.getDocteursBySpecialite('Orthopédiste'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur de chargement des données'));
            } else {
              return DocteurWidget();
            }
          },
        ),
      ),
    );
  }
}
