import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/providers/user_provider.dart";
import "package:frontend/services/authentication_service.dart";
import "package:frontend/views/Login/index.dart";
import "package:frontend/views/Onboarding/index.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/snackbar_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/textfield_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";
import "package:provider/provider.dart";

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

  bool _isValid = true;

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
    final UserProvider _userProvider = Provider.of<UserProvider>(context);

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
            fieldIsValid: true,
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
            fieldIsValid: _isValid,
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
            fieldIsValid: _isValid,
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
            fieldIsValid: _isValid,
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

  Future<void> signUpWithEmail({
    required UserProvider userProvider,
    required String name,
    required String email,
    required String password
  }) async {
    try {
      await MakerSyncAuthentication().signUpWithEmail(name, email, password);

      await userProvider.addUserCredential(
        email: email,
        name: name
      );

      const MSSnackbarWidget(
        message: "Successfully created an account!",
      ).showSnackbar(context);

      print("Sign up success!");

    } catch (e) {
      print("Sign up failed!: $e");
    }
  }
}