import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:google_sign_in/google_sign_in.dart";


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

  Future<dynamic> authenticationSignInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on Exception catch (e) {
      print('exception->$e');
    }
  }



  Future<void> authenticationLogout() async {
    await _auth.signOut();
    return;
  }

  String get getUserEmail => _auth.currentUser?.email ?? "";
  String get getUserDisplayName => _auth.currentUser?.displayName ?? "";
}