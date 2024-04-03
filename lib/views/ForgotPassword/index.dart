import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/textfield_widget.dart";


class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({ super.key });

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController(text : "");

  @override
  void dispose() {
    super.dispose();

    _email.dispose();
  }

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
            child : content()
          )
        )
      )
    );
  }

  Widget content() {
    return Form(
      key: _form,
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children : [
          MSBackButtonWidget(
            btnOnTap: navigateToLogin,
          ),

          SizedBox(height : 30.h),
          
          MSTextWidget(
            "Forgot Password",
            fontSize: 26.sp,
            fontColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          
          SizedBox(height : 5.h),
                
          const MSTextWidget(
            "Effortless account recovery! Enter your email address to\nquickly restore access and track your progress.",
          ),
      
          SizedBox(height : 30.h),
      
          MSTextFieldWidget(
            controller : _email,
            fieldLabelText: "Email Address",
            fieldBackground: (Theme.of(context).brightness == Brightness.dark) 
              ? Theme.of(context).colorScheme.tertiary
              : Colors.grey.shade50,
            fieldBorderColor: (Theme.of(context).brightness == Brightness.dark)
              ? Colors.grey.shade600
              : Theme.of(context).colorScheme.tertiary,
            fieldLabelColor: (Theme.of(context).brightness == Brightness.dark) 
              ? Colors.grey.shade400 
              : Colors.grey.shade600
          ),
      
          SizedBox(height : 30.h),
          
          MSButtonWidget(
            btnOnTap: (){},
            btnColor : Theme.of(context).colorScheme.primary,
            child : Center(
              child : MSTextWidget(
                "Submit",
                fontSize : 16.sp,
                fontColor : Colors.white,
                fontWeight: FontWeight.w600
              )
            )
          ),
        ]
      )
    );
  }

  void navigateToLogin(){
    Navigator.of(context).pop();
  }
}