import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/services/authentication_service.dart";
import "package:frontend/utils/form_validator.dart";
import "package:frontend/views/Dashboard/index.dart";
import "package:frontend/views/Login/index.dart";
import "package:frontend/views/Onboarding/index.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/snackbar_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/textfield_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";

class RegisterView extends StatefulWidget {
  const RegisterView({ super.key });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController(text : "");
  final TextEditingController _email = TextEditingController(text : "");
  final TextEditingController _password = TextEditingController(text : "");
  final TextEditingController _rePassword = TextEditingController(text : "");

  bool _isLoading = false;

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
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children : [
          MSBackButtonWidget(
            btnOnTap: navigateToOnboarding,
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
            fieldValidator: (value) => FormValidator()
              .validateInput(value, "Name", 2, 50),
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
      
          MSTextFieldWidget(
            controller : _rePassword,
            fieldIsObsecure: true,
            fieldLabelText: "Confirm Password",
            fieldValidator: (value) => FormValidator()
              .validateConfirmPassword(value, _password.text.trim()),
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
            btnOnTap: () async {
              if(_form.currentState!.validate()){
                _form.currentState!.save();
                await signUpWithEmail();
              } 
            },
            btnIsLoading: _isLoading,
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

  void navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder : (context) => const OnboardingView()
      )
    );
  }

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder : (context) => const LoginView(),
      )
    );
  }

  Future<void> signUpWithEmail() async {
    try {
      setState(() => _isLoading = true);

      await MakerSyncAuthentication().signUpWithEmail(
        _name.text.trim(),
        _email.text.trim(),
        _password.text.trim(),
      );

      const MSSnackbarWidget(
        message: "Successfully created an account!",
      ).showSnackbar(context);

      Future.delayed(
        const Duration(seconds: 1),
          () => setState(() => _isLoading = false)
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardView()));

    } on FirebaseAuthException catch (e) {
      print("Sign up failed!: ${e.code}");

      MSSnackbarWidget(
        message: (e.code == "invalid-credential") 
          ? "Invalid credentials." 
          : (e.code == "email-already-in-use") 
          ? "Email already in use. Please try another." 
          : "Error! Please try again.",
      ).showSnackbar(context);

      setState(() => _isLoading = false);
    }
  }
}