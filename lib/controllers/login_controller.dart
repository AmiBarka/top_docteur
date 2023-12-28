import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:top_docteur/services/login_service.dart';

class LoginController extends GetxController {
  final LoginServices _loginServices = LoginServices();
  var isSigningIn = false.obs;

  void setISSigningIn(var newValue) {
    isSigningIn.value = newValue;
  }

  Future<String> login(String email, String password) async {
    setISSigningIn(true);
    String result = await _loginServices.login(email, password);
    setISSigningIn(false);
    return result;
  }
}

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Ajoutez ceci

  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    // Écoutez les changements d'état d'authentification
    _auth.authStateChanges().listen((User? user) {
      currentUser.value = user;
    });
  }

  Future<String?> register({
    required String nom,
    required String email,
    required String tel,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Enregistrez des informations supplémentaires dans Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'nom': nom,
        'email': email,
        'tel': tel,
        // Ajoutez d'autres champs si nécessaire
      });

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      print('Registration Error: $e');
      return null;
    }
  }
}
