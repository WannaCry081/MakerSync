import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:frontend/views/Dashboard/index.dart";
import "package:frontend/views/Error/index.dart";
import "package:frontend/views/Loading/index.dart";
import "package:frontend/views/Onboarding/index.dart";

class AuthViewBuilder extends StatelessWidget {
  const AuthViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?> (
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView();
          } else if (snapshot.hasData) {
            return DashboardView();
          } else if (snapshot.hasError) {
            return const ErrorView();
          } else {
            return const OnboardingView();
          }
        }
      )
    );
  }
}