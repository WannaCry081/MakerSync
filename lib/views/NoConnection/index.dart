import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MSWrapperWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 22.h,
          ),
          
          child: content(context),
        ),
      )
    );
  }

  Widget content(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/svgs/NoConnection.svg"
            ),

            SizedBox(height: 5.h),

            MSTextWidget(
              "Ooops!",
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontColor: Theme.of(context).colorScheme.onBackground,
            ),

            SizedBox(height: 4.h),

            MSTextWidget(
              "No internet connection found.\nPlease check your internet connection and try again.",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              fontColor: Colors.grey.shade600,
              fontHeight: 2.h,
            ),


          ],
        ),
      )
    );
  }
}