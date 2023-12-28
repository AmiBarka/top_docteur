import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_docteur/controllers/login_controller.dart';

import 'package:top_docteur/screens/auth/login_screen.dart';
import 'package:top_docteur/widgets/custom_fild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController telController = TextEditingController();

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset("assets/images/doctors.png"),
              ),
              const SizedBox(height: 15),
              CustomField(
                controller: nomController,
                label: "Full Name",
                prefixIcon: Icons.person,
              ),
              CustomField(
                controller: emailController,
                label: "Email Address",
                prefixIcon: Icons.email,
              ),
              CustomField(
                controller: telController,
                label: "Phone Number",
                prefixIcon: Icons.phone,
              ),
              CustomField(
                controller: passwordController,
                label: "Enter Password",
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  String? result = await authController.register(
                    nom: nomController.text,
                    email: emailController.text.trim(),
                    tel: telController.text,
                    password: passwordController.text,
                  );

                  if (result != null) {
                    print('Registration Successful');
                    // Si l'enregistrement est réussi, naviguer vers la page de connexion
                    Get.off(() => loginScreen());
                  } else {
                    print('Registration Failed');
                    // Si l'enregistrement échoue, afficher un message d'erreur
                    Get.snackbar(
                      "Échec de l'inscription",
                      "Une erreur s'est produite lors de l'inscription.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      duration: Duration(seconds: 3),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: 350,
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
                      "Create Account",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => loginScreen());
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7165D6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
