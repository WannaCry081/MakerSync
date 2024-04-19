import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:frontend/views/Dashboard/index.dart";
import "package:google_sign_in/google_sign_in.dart";


class MakerSyncAuthentication {
  
  final _auth = FirebaseAuth.instance;
  GoogleSignInAccount? _googleUser;

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      
      print("sign in success!");
      return true;
    } on FirebaseAuthException catch (_) {
      print("sign in failed!");
      return false;
    }
  }

  Future<void> signUpWithEmail (
    String name,
    String email,
    String password,
    BuildContext context
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      credential.user?.updateDisplayName(name);
      // credential.user?.updatePhotoURL();

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DashboardView()));
        }
    });

    } on FirebaseAuthException catch (_) {
      print("sign up failed!");
    }
  }

  Future<List<String>> signInWithGoogle() async {
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
    if (_googleUser != null) {
      await GoogleSignIn().signOut();
    }

    await _auth.signOut();
    _googleUser = null;
    return;
  }

  String get getUserEmail => _auth.currentUser?.email ?? "";
  String get getUserDisplayName => _auth.currentUser?.displayName ?? "";
  String get getUserPhotoUrl => _auth.currentUser?.photoURL ?? "";

}