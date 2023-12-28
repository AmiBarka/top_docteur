import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_docteur/screens/Auth/register.dart';
import 'package:top_docteur/widgets/custom_fild.dart';
import 'package:top_docteur/widgets/login_bution.dart';

// ignore: must_be_immutable
class loginScreen extends StatelessWidget {
  loginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                child: Image.asset(
                  "assets/images/doctors.png",
                ),
              ),
              const SizedBox(height: 20),
              CustomField(
                controller: emailController,
                label: "Enter Username",
                prefixIcon: Icons.person,
              ),
              CustomField(
                controller: passwordController,
                label: "Enter Password",
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              LoginButton(
                emailController: emailController,
                passwordController: passwordController,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have any account?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => SignUpScreen());
                    },
                    child: const Text(
                      "Create Account",
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
