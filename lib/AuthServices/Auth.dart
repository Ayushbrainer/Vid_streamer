import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServ {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  //sign in with email & password

  Future SignIn(String password, String email) async {
    try {
      dynamic result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
