import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:frontend/views/Dashboard/Settings/change_password_view.dart';
import 'package:frontend/views/Dashboard/Settings/dark_mode.dart';
import 'package:frontend/views/Dashboard/Settings/profile_view.dart';
import 'package:frontend/views/Onboarding/index.dart';
import 'package:frontend/widgets/button_widget.dart';
import 'package:frontend/widgets/snackbar_widget.dart';
import 'package:frontend/widgets/text_widget.dart';
import 'package:frontend/widgets/wrapper_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late SettingsProvider settings;
  late UserProvider userProvider;

  bool _showDisconnectButton = false;
  bool _isNotifications = false;

  UserModel? _user;

  
  @override
  Widget build(BuildContext context) {

    settings = Provider.of<SettingsProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    setState(() => _showDisconnectButton = settings.getBool("isConnect"));

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),

        MSTextWidget(
          "Settings",
          fontSize: 26.sp,
          fontColor: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold
        ),

        SizedBox(height: 30.h),

        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.tertiary
              : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.grey.shade600
                : Colors.grey.shade200
            )
          ),
          child: Column(
            children: [
              settingsItem(
                context: context,
                iconData: FeatherIcons.user,
                title: "Profile",
                widget: Icon(
                  FeatherIcons.chevronRight,
                  color: Theme.of(context).colorScheme.onBackground),
                onTap: navigateToProfile
              ),
            
              settingsItem(
                context: context,
                iconData: FeatherIcons.lock,
                title: "Change Password",
                widget: Icon(
                  FeatherIcons.chevronRight,
                  color: Theme.of(context).colorScheme.onBackground),
                onTap: navigateToChangePassword
              ),

              settingsItem(
                context:context,
                iconData: FeatherIcons.moon,
                title: "Dark Mode",
                widget: Icon(
                  FeatherIcons.chevronRight,
                  color: Theme.of(context).colorScheme.onBackground),
                onTap: navigateToDarkMode
              ),

              settingsItem(
                context: context,
                iconData: FeatherIcons.bell,
                title: "Notifications",
                widget: Switch(
                  value: _isNotifications,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: ((bool value) {
                    setState(() => _isNotifications = value);
                  })
                ),
                isLast: true
              ),

              SizedBox(height: 10.h)
            ]
          )
        ),
        
        const Spacer(),

        if(_showDisconnectButton)
          MSButtonWidget(
            btnOnTap: disconnectFromDevice,
            btnColor: Colors.red.shade300,
            child: Center(
              child: MSTextWidget(
                "Disconnect from Device",
                fontColor: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600
              )
            )
          ),
        
        SizedBox(height: 15.h),

        MSButtonWidget(
          btnOnTap: navigateToOnboarding,
          btnColor: Theme.of(context).colorScheme.primary,
          child: Center(
            child: MSTextWidget(
              "Log out",
              fontColor: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600
            )
          )
        ),
      ]
    );
  }

  Widget settingsItem({
    required BuildContext context,
    required IconData iconData,
    required String title,
    required Widget widget,
    void Function() ? onTap,
    bool isLast = false,
  }) 
  {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 10.h, 
                  left: 15.w, 
                  right: 10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 8.w
                      ),
                      decoration:  BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Icon(
                        iconData,
                        color: Colors.white
                      )
                    ),
          
                    SizedBox(width: 15.w),
          
                    MSTextWidget(
                      title,
                      fontSize: 16.sp,
                    ),
          
                    const Spacer(),
      
                    widget,
                  ]
                ),
              ),
            ],
          ),
      
          if (!isLast)
          Row(
            children: [
              Expanded(
                child: Divider( 
                  indent: 70, 
                  height: 10.h, 
                  color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade600
                    : Colors.grey.shade200 )) 
            ],
          ),
        ],
      ),
    );
  }

  void navigateToProfile(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProfileView()
      )
    );
  }

  void navigateToChangePassword(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChangePasswordView()
      )
    );
  }

  void navigateToDarkMode(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DarkModeView()
      )
    );
  }

  void navigateToOnboarding() {
     PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const OnboardingView(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  Future<void> authenticationLogout() async {
    await MakerSyncAuthentication().authenticationLogout();
    return;
  }

  Future<void> disconnectFromDevice() async {
    
    settings.setBool("isConnect", false);

    await userProvider.deleteUserCredential(
      email: _user?.email ?? ""
    );

    const MSSnackbarWidget(
      message: "Successfully disconnected from device!",
    ).showSnackbar(context);

    setState(() => _showDisconnectButton = settings.getBool("isConnect"));
  }
}