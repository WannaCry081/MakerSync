import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/widgets/wrapper_widget.dart";


class LoginView extends StatefulWidget {
  const LoginView({ super.key });

  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : MSWrapperWidget(
        child : Padding(
          padding : EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 22.h
          ),
          
          child : Center(
            child : Text("Hi")
          )
        )
      )
    );
  }
}