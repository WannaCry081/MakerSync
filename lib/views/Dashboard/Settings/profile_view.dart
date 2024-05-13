import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/models/user_model.dart";
import "package:frontend/providers/settings_provider.dart";
import "package:frontend/providers/user_provider.dart";
import "package:frontend/services/authentication_service.dart";
import "package:frontend/utils/form_validator.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/snackbar_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/textfield_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";
import "package:provider/provider.dart";

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  late UserModel? _user;
  late UserProvider _userProvider;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late TextEditingController _currentDisplayName;
  late TextEditingController _newDisplayName;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _user = context.read<UserProvider>().getUserData();
    _currentDisplayName = TextEditingController(text: _user?.username);
    _newDisplayName = TextEditingController(text: "");
  }

  @override
  void dispose(){
    super.dispose();
    
    _currentDisplayName.dispose();
    _newDisplayName.dispose();
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
    final SettingsProvider _settingsProvider = Provider.of<SettingsProvider>(context);
    final bool _isConnect = _settingsProvider.getBool("isConnect");
    final auth = MakerSyncAuthentication();

    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MSBackButtonWidget(
                btnOnTap: () => Navigator.of(context).pop()
                // btnOnTap: navigateToSettings
              ),

              SizedBox(width: 15.w),

              MSTextWidget(
                "Profile",
                fontSize: 26.sp, 
                fontColor: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
      
          SizedBox(height: 40.h),
      
          GestureDetector(
            onTap: (){},
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children:[

                  CircleAvatar(
                    radius: 75.r,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    backgroundImage: NetworkImage(auth.getUserPhotoUrl),
                  ),
                  
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: Container(
                  //     height: 45.h,
                  //     width: 45.w,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Theme.of(context).colorScheme.secondary,
                  //     ),
                  //     child: Icon(
                  //       FeatherIcons.camera,
                  //       color: Theme.of(context).colorScheme.background
                  //     ),
                  //   )
                  // )
                ]
              )
            ),
          ),

          SizedBox(height: 30.h),

          if(!_isConnect)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),

                MSTextWidget(
                  "Oops! You are not yet connected :<",
                  textAlign: TextAlign.center,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontColor: Theme.of(context).colorScheme.onBackground,
                ),

                SizedBox(height: 5.h),

                MSTextWidget(
                  "Please connect to the device to edit your profile.",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  fontColor: Colors.grey.shade600,
                  fontHeight: 1.5.h,
                ),
              ]
            ),
          ),

          if(_isConnect)
          Column(
            children: [
              MSTextFieldWidget(
                controller : _currentDisplayName,
                fieldIsReadOnly: true,
                fieldIsValid: true,
                fieldLabelText: "Current Display Name",
                fieldBackground: (Theme.of(context).brightness == Brightness.dark) 
                  ? Theme.of(context).colorScheme.tertiary
                  : Colors.grey.shade50,
                fieldBorderColor: (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.grey.shade600
                  : Colors.grey.shade300,
                fieldLabelColor: (Theme.of(context).brightness == Brightness.dark) 
                  ? Colors.grey.shade400 
                  : Colors.grey.shade600
              ),

              SizedBox(height : 15.h),

              MSTextFieldWidget(
                controller : _newDisplayName,
                fieldLabelText: "New Display Name",
                fieldValidator: (value) => FormValidator()
                  .validateInput(value, "Name", 2, 20),
                fieldBackground: (Theme.of(context).brightness == Brightness.dark) 
                  ? Theme.of(context).colorScheme.tertiary
                  : Colors.grey.shade50,
                fieldBorderColor: (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.grey.shade600
                  : Colors.grey.shade300,
                fieldLabelColor: (Theme.of(context).brightness == Brightness.dark) 
                  ? Colors.grey.shade400 
                  : Colors.grey.shade600
              ),
            ],
          ),

          SizedBox(height : 15.h),

          const Spacer(),

          SizedBox(height : 15.h),

          MSButtonWidget(
            btnOnTap: () async {
              if (_form.currentState!.validate()){
                _form.currentState!.save();
                await updateUser();
              } 
            },
            btnIsLoading: _isLoading,
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
  

 Future<void> updateUser() async {
  setState(() => _isLoading = true);

  await _userProvider.updateUserCredential(
    email: _user?.email ?? "",
    username: _newDisplayName.text.trim()
  );

  Future.delayed(
    const Duration(seconds: 1),
      () => setState(() => _isLoading = false)
  );

  const MSSnackbarWidget(
    message: "Successfully updated your display name!",
  ).showSnackbar(context);

  await Future.delayed(const Duration(seconds: 2));
  Navigator.of(context).pop();
}

}