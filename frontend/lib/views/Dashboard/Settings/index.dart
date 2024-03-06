import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/views/Dashboard/Settings/change_password_view.dart';
import 'package:frontend/views/Dashboard/Settings/dark_mode.dart';
import 'package:frontend/views/Dashboard/Settings/profile_view.dart';
import 'package:frontend/widgets/button_widget.dart';
import 'package:frontend/widgets/text_widget.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 22.h,
            horizontal: 22.w
          ),
          child: Column(
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
                    : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.grey.shade600
                      : Colors.grey.shade300
                  )
                ),
                child: Column(
                  children: [
                    settingsItem(
                      context,
                      const Icon(FeatherIcons.user, color: Colors.white),
                      "Profile",
                      Icon(
                        FeatherIcons.chevronRight,
                        color: Theme.of(context).colorScheme.onBackground),
                      (){}
                    ),
                  
                    settingsItem(
                      context,
                      const Icon(FeatherIcons.lock, color: Colors.white),
                      "Change Password",
                      Icon(
                        FeatherIcons.chevronRight,
                        color: Theme.of(context).colorScheme.onBackground),
                      (){}
                    ),
      
                    settingsItem(
                      context,
                      const Icon(FeatherIcons.moon, color: Colors.white),
                      "Dark Mode",
                      Icon(
                        FeatherIcons.chevronRight,
                        color: Theme.of(context).colorScheme.onBackground),
                      (){}
                    ),
      
                    settingsItem(
                      context,
                      const Icon(FeatherIcons.bell, color: Colors.white), 
                      "Notifications",
                      Switch(
                        value: _isNotifications,
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: ((bool value) {
                          setState(() => _isNotifications = value);
                        })
                      ),
                      (){},
                      isLast: true
                    ),
      
                    SizedBox(height: 10.h)
                  ]
                )
              ),
              const Spacer(),
      
              MSButtonWidget(
                btnOnTap: (){},
                btnColor: Colors.red.shade300,
                child: Center(
                  child: MSTextWidget(
                    "Disconect from Device",
                    fontColor: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                  )
                )
              ),
              
              SizedBox(height: 15.h),
      
              MSButtonWidget(
                btnOnTap: (){},
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
          ),
        )
      )
    );
  }

  Widget settingsItem(
    BuildContext context, 
    Icon icon, 
    String title, 
    Widget widget, 
    void Function() onTap,
    {bool isLast = false}) 
  {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 10),
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
                      child: icon
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
                    : Colors.grey.shade300
              )) 
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
}