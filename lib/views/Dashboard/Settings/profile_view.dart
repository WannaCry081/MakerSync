import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:frontend/services/authentication_service.dart";
import "package:frontend/views/Dashboard/Settings/index.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/textfield_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _currentDisplayName = TextEditingController(text: "Shiela Mae");
  final TextEditingController _newDisplayName = TextEditingController(text: "");

  @override
  void dispose(){
    super.dispose();

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

    final _auth = MakerSyncAuthentication();

    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MSBackButtonWidget(
                btnOnTap: navigateToSettings
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
                    backgroundImage: NetworkImage(_auth.getUserPhotoUrl),
                  ),
                  
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Icon(
                        FeatherIcons.camera,
                        color: Theme.of(context).colorScheme.background
                      ),
                    )
                  )
                ]
              )
            ),
          ),

          SizedBox(height: 30.h),

          MSTextFieldWidget(
            controller : _currentDisplayName,
            fieldIsReadOnly: true,
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

          const Spacer(),

          SizedBox(height : 15.h),

          MSButtonWidget(
            btnOnTap: (){},
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

  void navigateToSettings(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsView()
      )
    );
  }
}