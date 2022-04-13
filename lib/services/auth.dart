import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user.dart';

class AuthService {
  // Auth
  final authInstance = FirebaseAuth.instance;

  Utilisateur? _userFromFirebaseUser(User user) {
    return user != null ? Utilisateur(uid: user.uid) : null;
  }

  //Connexion
  Future<Utilisateur?> signInWithEmailAndPassword(
      String mail, String pwd) async {
    try {
      final userCredential = await authInstance.signInWithEmailAndPassword(
          email: mail, password: pwd);
      final User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future signOut() async {
    try {
      return await authInstance.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await authInstance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
