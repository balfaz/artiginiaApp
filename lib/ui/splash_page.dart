import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return checkUserIsLogged().then((isLogin) {
      if (isLogin) {
        print('Utente già loggato');
        Navigator.of(context).pushReplacementNamed('home');
      } else {
        print('Utente non loggato');
        Navigator.of(context).pushReplacementNamed('login2');
      }
    });
  }

  checkUserIsLogged() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    /* return _auth
        .currentUser()
        .then((user) => user != null ? true : false)
        .catchError((error) => false); */
    if (_auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
