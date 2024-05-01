import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/services/authentication_service.dart";
import "package:frontend/utils/form_validator.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/snackbar_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/textfield_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _currentPassword = TextEditingController(text: "");
  final TextEditingController _newPassword = TextEditingController(text: "");
  final TextEditingController _confirmNewPassword = TextEditingController(text: "");

  bool _isLoading = false;

  @override
  void dispose(){
    super.dispose();

    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmNewPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).colorScheme.background
        : null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: Theme.of(context).brightness == Brightness.dark
          ? null
          : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                  Theme.of(context).colorScheme.secondary
                ]
              )
            ),
        child: MSWrapperWidget(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 22.w,
              vertical: 22.h
            ),

            child: content()
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
        children: [
          MSBackButtonWidget(
            btnOnTap: () => Navigator.of(context).pop()
          ),
      
          SizedBox(height: 20.h),
      
          MSTextWidget(
            "Change Password",
            fontSize: 26.sp,
            fontColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),

          SizedBox(height : 5.h),
                
          const MSTextWidget(
            "Your password should be at least 6 characters and\nshould include a combination of numbers, letters,\nand special characters.",
          ),
      
          SizedBox(height: 30.h),

          MSTextFieldWidget(
            controller : _currentPassword,
            fieldIsObsecure: true,
            fieldLabelText: "Current Password",
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
            controller : _newPassword,
            fieldLabelText: "New Password",
            fieldIsObsecure: true,
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
            controller : _confirmNewPassword,
            fieldLabelText: "Confirm New Password",
            fieldIsObsecure: true,
            fieldValidator: (value) => FormValidator()
              .validateConfirmPassword(value, _newPassword.text),
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

          const Spacer(),

          SizedBox(height : 15.h),

          MSButtonWidget(
            btnOnTap: () async {
              if(_form.currentState!.validate()) {
                _form.currentState!.save();
                await authenticationChangePassword();
              }
            },
            btnColor: Theme.of(context).colorScheme.primary,
            child: Center(
              child: MSTextWidget(
                "Save Changes",
                fontColor: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600
              )
            )
          ),
        ]
      ),
    );
  }

  Future<void> authenticationChangePassword() async {
    try {
      setState(() => _isLoading = true);

      await MakerSyncAuthentication().authenticationChangePassword(
        _currentPassword.text.trim(),
        _newPassword.text.trim()
      );

      Future.delayed(
        const Duration(seconds: 1),
          () => setState(() => _isLoading = false)
      );

      const MSSnackbarWidget(
        message: "Successfully updated your password!",
      ).showSnackbar(context);

      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pop();

    } on FirebaseAuthException catch(e) {
      print("Change password failed!: ${e.code}");

      MSSnackbarWidget(
        message: (e.code == "invalid-credential") 
          ? "Wrong password." 
          : "System Error",
      ).showSnackbar(context);

      setState(() => _isLoading = false);
    }

  }

}