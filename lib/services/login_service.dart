import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginServices {
  Future<String> login(String email, String password) async {
    print("--" * 30);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
      return "";
      // Handle error, show error message, etc.
    }
  }
}

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<String?> register({
//     required String nom,
//     required String email,
//     required String tel,
//     required String password,
//   }) async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Enregistrez des informations supplémentaires dans Firestore
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'nom': nom,
//         'email': email,
//         'tel': tel,
//         // Ajoutez d'autres champs si nécessaire
//       });

//       return userCredential.user!.uid;
//     } on FirebaseAuthException catch (e) {
//       print('Registration Error: $e');
//       return null;
//     }
//   }

//   Future<Map<String, dynamic>?> getUserData(String uid) async {
//     try {
//       DocumentSnapshot userSnapshot =
//           await _firestore.collection('users').doc(uid).get();

//       if (userSnapshot.exists) {
//         return userSnapshot.data() as Map<String, dynamic>;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//       return null;
//     }
//   }

//   // Ajoutez d'autres méthodes d'authentification si nécessaire
// }
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

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

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'nom': nom,
        'email': email,
        'tel': tel,
      });

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      print('Registration Error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
