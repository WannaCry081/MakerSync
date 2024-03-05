import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/views/Login/index.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/textfield_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";

class RegisterView extends StatefulWidget {
  const RegisterView({ super.key });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final TextEditingController _name = TextEditingController(text : "");
  final TextEditingController _email = TextEditingController(text : "");
  final TextEditingController _password = TextEditingController(text : "");
  final TextEditingController _rePassword = TextEditingController(text : "");

  @override
  void dispose(){
    super.dispose();

    _name.dispose();
    _email.dispose();
    _password.dispose();
    _rePassword.dispose();
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

  Widget content(){
    return Form(
      child: Column(
        children : [
          MSBackButtonWidget(
            btnOnTap: (){},
          ),
      
          SizedBox(height : 30.h),
          
          MSTextWidget(
            "Get Started!",
            fontSize: 26.sp,
            fontColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          
          SizedBox(height : 5.h),
                
          const MSTextWidget(
            "It's free, secure and easy. Create an account and\nstart tracking your progress in one go!",
          ),
      
          SizedBox(height : 30.h),
      
          MSTextFieldWidget(
            controller : _name,
            fieldLabelText: "Full Name",
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
      
          MSTextFieldWidget(
            controller : _rePassword,
            fieldIsObsecure: true,
            fieldLabelText: "Confirm Password",
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
                "Sign Up",
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
                "Already have an account? ",
              ),
      
              GestureDetector(
                onTap : navigateToLogin,
                child : MSTextWidget(
                  "Sign In", 
                  fontColor: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                )
              )
            ]
          )
        ]
      ),
    );
  }

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder : (context) => const LoginView(),
      )
    );
  }
}