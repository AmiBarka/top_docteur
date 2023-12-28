import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_docteur/controllers/login_controller.dart';
import 'package:top_docteur/widgets/constate.dart';
import 'package:top_docteur/widgets/navbar_roots.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginController loginController = Get.put(LoginController());

  LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () async {
          try {
            // Récupérer l'adresse e-mail et le mot de passe depuis les contrôleurs
            String email = emailController.text.trim();
            String password = passwordController.text;

            // Vérifier si l'adresse e-mail est vide ou mal formatée
            if (email.isEmpty ||
                !RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                    .hasMatch(email)) {
              Get.defaultDialog(
                title: "Erreur de connexion",
                titleStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                content: Container(
                  padding: EdgeInsets.all(16),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 60, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        "Veuillez fournir une adresse e-mail valide",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                radius: 10.0,
                actions: [
                  TextButton(
                    onPressed: () {
                      // Fermer la boîte de dialogue en appuyant sur le bouton OK
                      Get.back();
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
              return;
            }

            // Vérifier si le mot de passe est vide
            if (password.isEmpty) {
              Get.snackbar(
                "Erreur de connexion",
                "Veuillez fournir un mot de passe",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: Duration(seconds: 3),
              );
              return;
            }

            // Appeler la fonction de connexion
            String result = await loginController.login(email, password);

            // Vérifier le résultat et afficher un message en conséquence
            if (result.isNotEmpty) {
              Get.defaultDialog(
                title: "Connexion réussie",
                content: Container(
                  padding: EdgeInsets.all(16),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, size: 60, color: primaryColor),
                      SizedBox(height: 16),
                      Text(
                        "Bienvenue",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                titleStyle: const TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                radius: 10.0,
                actions: [
                  TextButton(
                    onPressed: () {
                      // Naviguer vers la page ListHotels après la connexion réussie
                      Get.to(() => const NavBarRoots());
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            } else {
              Get.defaultDialog(
                title: "Échec de la connexion",
                content: Container(
                  padding: EdgeInsets.all(16),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 60, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        "Une erreur a été rencontrée ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                titleStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                radius: 10.0,
                actions: [
                  TextButton(
                    onPressed: () {
                      // Fermer la boîte de dialogue en appuyant sur le bouton OK
                      Get.back();
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }
          } catch (e) {
            // Gérer toute exception imprévue ici
            print('Login Error: $e');
            Get.snackbar(
              "Erreur de connexion",
              "Une erreur inattendue s'est produite",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: Duration(seconds: 3),
              boxShadows: [
                BoxShadow(
                  offset: const Offset(4, 0),
                  blurRadius: 16,
                  color: Colors.grey[300]!,
                )
              ],
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF7165D6),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "Log In",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
