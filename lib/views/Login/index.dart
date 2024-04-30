import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/services/authentication_service.dart";
import "package:frontend/utils/form_validator.dart";
import "package:frontend/views/Dashboard/index.dart";
import "package:frontend/views/Onboarding/index.dart";
import "package:frontend/views/ForgotPassword/index.dart";
import "package:frontend/views/Register/index.dart";
import "package:frontend/widgets/snackbar_widget.dart";
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

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();

    _email.dispose();
    _password.dispose();
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
      key : _form,
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children : [
          MSBackButtonWidget(
            btnOnTap: navigateToOnboarding,
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
            fieldValidator: (value) => FormValidator()
              .validateEmail(value),
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
            fieldValidator: (value) => FormValidator()
              .validatePassword(value),
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
              onTap: navigateToForgotPassword,
              child : const MSTextWidget(
                "Forgot Password?",
                fontWeight: FontWeight.w600,
              )
            ),
          ),
      
      
          SizedBox(height : 30.h),
          
          MSButtonWidget(
            btnOnTap: () async {
              if (_form.currentState!.validate()){

                _form.currentState!.save();
                await signInWithEmail();

              }
            },
            btnIsLoading: _isLoading,
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
                onTap : navigateToRegister,
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

  void navigateToOnboarding(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder : (context) => const OnboardingView()
      )
    );
  }

  void navigateToRegister() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder : (context) => const RegisterView()
      )
    );
  }

  void navigateToForgotPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (context) => const ForgotPasswordView(),
      )
    );
  } 

  Future<void> signInWithEmail() async {
    try {
      setState(() => _isLoading = true);

      await MakerSyncAuthentication().signInWithEmail(
        _email.text.trim(),
        _password.text.trim(),
      );

      const MSSnackbarWidget(
        message: "Successfully signed in into account!",
      ).showSnackbar(context);

      Future.delayed(
        const Duration(seconds: 1),
          () => setState(() => _isLoading = false)
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardView()));

      print("Sign in success in login view!");
    } on FirebaseAuthException catch (e) {

      print("Sign in failed in login view!: ${e.code}");
    }
  }
}