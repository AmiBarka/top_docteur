import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_docteur/screens/specialiter/Cardiologue.dart';
import 'package:top_docteur/screens/specialiter/Dermatologue.dart';
import 'package:top_docteur/screens/specialiter/Orthopediste.dart';
import 'package:top_docteur/screens/specialiter/Pediatre.dart';
import 'package:top_docteur/widgets/constate.dart';
import 'package:top_docteur/widgets/widget_specialite.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(90.0), // Ajustez la hauteur selon vos préférences
          child: Container(
            color: primaryColor,
            alignment: Alignment.center,
            child: const Text(
              'Spécialités',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors
                    .white, // Changer la couleur du texte selon vos préférences
              ),
            ),
          ),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            CategoryWidget(
              categoryName: 'Pediatre',
              color: Colors.blue,
              icon: Icons.child_care,
              onPressed: () {
                Get.to(() => PediatrePage());

                // Add your specific action for Pediatre
                print('Navigate to Pediatre page');
              },
            ),
            CategoryWidget(
              categoryName: 'Orthopédiste',
              color: Colors.green,
              icon: Icons.accessibility,
              onPressed: () {
                // Add your specific action for Orthopédiste
                Get.to(() => DocteurPage());
                print('Navigate to Orthopédiste page');
              },
            ),
            CategoryWidget(
              categoryName: 'Dermatologue',
              color: Colors.orange,
              icon: Icons.face,
              onPressed: () {
                Get.to(() => DermatologuePage());
                // Add your specific action for Dermatologue
                print('Navigate to Dermatologue page');
              },
            ),
            CategoryWidget(
              categoryName: 'Cardiologue',
              color: Colors.purple,
              icon: Icons.favorite,
              onPressed: () {
                Get.to(() => CardiologuePage());
                // Add your specific action for Cardiologue
                print('Navigate to Cardiologue page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
