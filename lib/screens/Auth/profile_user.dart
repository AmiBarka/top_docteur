import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_docteur/controllers/login_controller.dart';
import 'package:top_docteur/widgets/widgets_profile.dart';

class ProfilePage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: _firestore
              .collection('users')
              .doc(_authController.currentUser.value?.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text('Données utilisateur non trouvées');
            } else {
              Map<String, dynamic> userData =
                  snapshot.data!.data() as Map<String, dynamic>;

              return ProfileWidget(userData: userData);
            }
          },
        ),
      ),
    );
  }
}
