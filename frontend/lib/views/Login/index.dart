import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/widgets/wrapper_widget.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/textfield_widget.dart";


class LoginView extends StatefulWidget {
  const LoginView({ super.key });

  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController(text : "");
  final TextEditingController _password = TextEditingController(text : "");

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
            child : content(context)
          )
        )
      )
    );
  }

  Widget content(BuildContext context){
    return Form(
      key : _form,
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children : [
          MSBackButtonWidget(
            btnOnTap: (){},
          ),
      
          SizedBox(height : 30.h),
          
          MSTextWidget(
            "Welcome Back!",
            fontSize: 26.sp,
            fontColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          
          SizedBox(height : 5.h),
                
          const MSTextWidget(
            "Enter an email address to create your MakerSync\naccount or sign in to an existing account.",
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
      
          SizedBox(height : 15.h),
      
          MSTextFieldWidget(
            controller : _password,
            fieldIsObsecure: true,
            fieldLabelText: "Password",
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
          
          SizedBox(height : 15.h),
      
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: (){},
              child : const MSTextWidget(
                "Forgot Password?",
                fontWeight: FontWeight.w600,
              )
            ),
          ),
      
      
          SizedBox(height : 30.h),
          
          MSButtonWidget(
            btnOnTap: (){},
            btnColor : Theme.of(context).colorScheme.primary,
            child : Center(
              child : MSTextWidget(
                "Login",
                fontSize : 16.sp,
                fontColor : Colors.white,
                fontWeight: FontWeight.w600
              )
            )
          ),
      
          const Spacer(),
      
          SizedBox(height : 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              const MSTextWidget(
                "Don't have an account? ",
              ),
      
              GestureDetector(
                onTap : (){},
                child : MSTextWidget(
                  "Sign Up", 
                  fontColor: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                )
              )
            ]
          )
        ]
      )
    );
  }

}