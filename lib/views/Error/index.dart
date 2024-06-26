import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";


class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svgs/ErrorView.svg",
              height: 80.h
            ),

            SizedBox(height: 15.h),

            MSTextWidget(
              "Ooops!",
              textAlign: TextAlign.center,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              fontColor: Theme.of(context).colorScheme.primary,
            ),

            SizedBox(height: 4.h),

            MSTextWidget(
              "Something went wrong.",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              fontColor: Colors.grey.shade600,
            ),

          ],
        ),
      )
    );
  }
}