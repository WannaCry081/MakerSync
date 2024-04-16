import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";


class MakerSyncAuthentication {
  
  final _auth = FirebaseAuth.instance;
  GoogleSignInAccount? _googleUser;

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

  Future<List<String>> authenticationSignInWithGoogle() async {
    _googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await _googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _auth.signInWithCredential(credential);

    return [
      _googleUser?.email ?? "",
      _googleUser?.displayName ?? "",
      _googleUser?.photoUrl ?? ""
    ];
  }

  Future<void> authenticationLogout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    return;
  }

  String get getUserEmail => _auth.currentUser?.email ?? "";
  String get getUserDisplayName => _auth.currentUser?.displayName ?? "";
  String get getUserPhotoUrl => _auth.currentUser?.photoURL ?? "";

}