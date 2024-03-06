import "package:flutter/material.dart";
import "package:frontend/views/Dashboard/Settings/index.dart";
import "package:frontend/widgets/back_button_widget.dart";

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MSBackButtonWidget(
          btnOnTap: navigateToSettings
        ),

      ]
    );
  }

  void navigateToSettings(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsView()
      )
    );
  }
}