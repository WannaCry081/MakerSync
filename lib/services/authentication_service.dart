import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";


class MakerSyncAuthentication {
  
  final _auth = FirebaseAuth.instance;

  Future<void> authenticationSignInEmailAndPassword (
    String email,
    String password
  ) async {

    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
    return;
  }

  Future<void> authenticationSignUpEmailAndPassword (
    String username,
    String email,
    String password
  ) async {

    await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );


    return;
  }
}