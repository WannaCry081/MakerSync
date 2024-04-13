import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/services/authentication_service.dart";
import "package:frontend/services/user_service.dart";
import "package:frontend/views/Login/index.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";


class OnboardingView extends StatelessWidget {
  const OnboardingView({ super.key });

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

  Widget content(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Stack(
            alignment: Alignment.center,
            children: [
              
              SvgPicture.asset(
                "assets/svgs/Blob1.svg",
                height: 280.h,
                width: 280.w,
                // ignore: deprecated_member_use
                color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.primary
                  : null,
              ),
              SvgPicture.asset(
                "assets/svgs/Meeting.svg",
                height: 240.h,
                width: 240.w,
              ),
            ],
          ),
        ),
        
        SizedBox(
          height : 120.h,
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children :[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  MSTextWidget(
                    "Maker",
                    fontColor : Theme.of(context).colorScheme.primary,
                    fontSize : 26.sp,
                    fontWeight: FontWeight.bold
                  ),
                  MSTextWidget(
                    "Sync",
                    fontColor : Theme.of(context).colorScheme.secondary,
                    fontSize : 26.sp,
                    fontWeight: FontWeight.bold
                  )
                ]
              ),
    
              SizedBox(height : 5.h),
        
              MSTextWidget(
                "Bridging Creativity and Precision in\nPETG Filament Crafting.",
                textAlign: TextAlign.center,
                fontSize: 16.sp,
                fontHeight: 1.6
              ),
        
            ]
          )
        ), 
        
        SizedBox(height : 25.h),
        
        SizedBox(
          child : Column(
            children : [
        
              MSButtonWidget(
                btnOnTap: () => navigateToLogin(context),
                btnColor : Theme.of(context).colorScheme.primary,
                child : Center(
                  child : MSTextWidget(
                    "Let's get started",
                    fontSize : 16.sp,
                    fontColor : Colors.white,
                    fontWeight: FontWeight.w600
                  )
                )
              ),
        
              SizedBox(height : 10.h),
        
              MSButtonWidget(
                btnOnTap: _signInGoogleAuth,
                btnColor : Theme.of(context).colorScheme.tertiary,
                child :  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    SvgPicture.asset(
                      "assets/icons/Google.svg"
                    ),
          
                    SizedBox(width : 10.w), 
        
                    MSTextWidget(
                      "Continue with Google",
                      fontSize : 16.sp,
                      fontWeight: FontWeight.w600
                    )
                  ]
                )
              )
            ]
          )
        ),
        
        SizedBox(height : 25.h),
        
        MSTextWidget(
          "By continuing, you agree MakerSync's",
          fontColor : Colors.grey.shade600,
          fontSize : 10.sp
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
            const MSTextWidget(
              "Terms of Service",
              textDecoration: TextDecoration.underline,
              fontWeight : FontWeight.w600
            ),
            MSTextWidget(
              " and ",
              fontColor : Colors.grey.shade600,
            ),
            const MSTextWidget(
              "Privacy Policy",
              textDecoration: TextDecoration.underline,
              fontWeight : FontWeight.w600
            ),
          ]
        )
      ],
    );
  }

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder : (context) => const LoginView()
      )
    );
  }

  Future<void> _signInGoogleAuth() async {
    await MakerSyncAuthentication().authenticationSignInWithGoogle();
    return; 
  }

}