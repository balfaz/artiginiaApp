import 'package:artigian_app/global/sign_in_google.dart';
import 'package:artigian_app/ui/home_page.dart';
import 'package:flutter/material.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
]);

class GoogleSignPage extends StatefulWidget {
  GoogleSignPage({Key? key}) : super(key: key);

  @override
  _GoogleSignPageState createState() => _GoogleSignPageState();
}

@override
class _GoogleSignPageState extends State<GoogleSignPage> {
  GoogleSignInAccount? _currentUser;

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    if (_currentUser != null) {
      Navigator.pushNamed(context, 'home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              //color: Colors.blue,
              child: const Text('Email'),
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            _googleButton(),
          ],
        ),
      ),
      //),
    );
  }

  _googleButton() {
    return ElevatedButton(
      //splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        });
      },
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      //highlightElevation: 0,
      //borderSide: BorderSide(color: Colors.grey),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage("assets/google_logo.png"),
              height: 35.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Sign In with Google',
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
            )
          ],
        ),
      ),
    );
  }
}
