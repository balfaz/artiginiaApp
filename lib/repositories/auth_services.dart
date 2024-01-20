import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:firebase_core/firebase_core.dart';

class AuthService {
  //String email;
  //String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final User _user = User;

  Future<String?> autenticandoSignIn(String email, String password) async {
    final result = await _handleSignIn(email.trim(), password.trim());
    if (result.user!.email != null) {
      Fluttertoast.showToast(
          msg: 'Login effettuato come \n ${result.user!.email}',
          backgroundColor: Colors.blue.shade300,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      //TODO: Procedura per salvare token usuario
    }
    return result.user!.email;
    //return CircularProgressIndicator();
  }

  Future<String?> registrandoSignUp(String email, String password) async {
    final result = await _handleSignUp(email.trim(), password.trim());
    if (result.user!.email != null) {
      Fluttertoast.showToast(
          msg: 'Registrazione avvenuta\ncon successo!',
          backgroundColor: Colors.blue.shade300,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      //TODO: Procedura per salvare token usuario
    }
    return result.user!.email;
    //return CircularProgressIndicator();
  }

  Future<UserCredential> _handleSignIn(String email, String password) async {
    UserCredential? _userCredential;
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userCredential;
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Errore Login: $e',
          backgroundColor: Colors.blue.shade300,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
    }
    return _userCredential!;
  }

  Future<UserCredential> _handleSignUp(String email, String password) async {
    UserCredential? _userCredential;
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //emailLog = email;
      return _userCredential;
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Errore Login: $e',
          backgroundColor: Colors.blue.shade300,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
    }
    return _userCredential!;
  }

  Future<String> onRecoveryPsw(String email) async {
    await _auth
        .sendPasswordResetEmail(email: email)
        .catchError((error) => print(error));
    return 'Email di recupero inviata';
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  /* Future<String> _onRecoveryPsw(String email) async {
    //final FirebaseAuth _auth = FirebaseAuth.instance;
    return await _auth.sendPasswordResetEmail(email: email)
    .catchError((error) =>
        Fluttertoast.showToast(
            msg: 'Error Reset: $error',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.blueAccent[100],
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16));

  } */
}
