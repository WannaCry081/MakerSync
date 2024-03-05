import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/widgets/wrapper_widget.dart";

class RegisterView extends StatefulWidget {
  const RegisterView({ super.key });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
            child : Text("Hello world")
          )
        )
      ) 
    );
  }
}