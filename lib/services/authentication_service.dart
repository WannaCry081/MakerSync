import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:frontend/views/Dashboard/index.dart";
import "package:frontend/views/Onboarding/index.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";


class MakerSyncAuthentication {
  
  final _auth = FirebaseAuth.instance;
  GoogleSignInAccount? _googleUser;

  Future<void> signInWithEmail(
    String email,
    String password,
    BuildContext context
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashboardView()));
      }
    });
      
      print("sign in success!");
    } on FirebaseAuthException catch (_) {
      print("sign in failed!");
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

  Future<void> authenticationLogout(BuildContext context) async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    _googleUser = null;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
        PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const OnboardingView(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }
      });

    return;
  }

  Future<void> authenticationChangePassword(
    String oldPassword, 
    String newPassword
  ) async {
    final currentUser = _auth.currentUser!;

    final credential = EmailAuthProvider.credential(
      email: currentUser.email!,
      password: oldPassword
    );

    await currentUser.reauthenticateWithCredential(credential);
    await currentUser.updatePassword(newPassword);
  }

  String get getUserEmail => _auth.currentUser?.email ?? "";
  String get getUserDisplayName => _auth.currentUser?.displayName ?? "";
  String get getUserPhotoUrl => _auth.currentUser?.photoURL ?? "";

}