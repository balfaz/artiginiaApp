import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
String? name;
String? email;
String? imageUrl;

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth =
      await googleAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  /* final AuthCredential userResult =
        await firebaseAuth.signInWithCredential(credential); */
  final UserCredential authResult =
      await _firebaseAuth.signInWithCredential(credential);
  final User user = authResult.user!;

  if (user != null) {
    assert(user.displayName != null);
    assert(user.photoURL != null);
    assert(user.email != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    if (name!.isEmpty) {
      name = name!.substring(0, name!.indexOf(" "));
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User? currentUser = _firebaseAuth.currentUser;
    assert(user.uid == currentUser!.uid);

    print('Login effettuato con successo ${user.displayName}');
    return '$user';
  }
  return googleAccount.displayName.toString();
}

void signOutGoogle() async {
  await _googleSignIn.signOut();
  print('utente Logout');
}
