import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/text_widget.dart";

class DisconnectedView extends StatelessWidget {
  final bool isScanFail;
  final void Function()? btnOnTap;

  const DisconnectedView({
    required this.isScanFail,
    required this.btnOnTap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25.w),
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/svgs/Blob2.svg", 
                // ignore: deprecated_member_use
                color: Theme.of(context).brightness == Brightness.dark 
                  ? Theme.of(context).colorScheme.primary
                  : null,
              ),
              Positioned.fill(
                child: Center(
                  child: SvgPicture.asset(
                    isScanFail ? "assets/svgs/ErrorScan.svg" : "assets/svgs/Search.svg", 
                    height: 400.h
                  ),
                ),
              ),
            ]
          ),
        ),
        
        SizedBox(height: 5.h),

        Column(
          children: [
            MSTextWidget(
              isScanFail 
                ? "Oops! Your scanned code seems to be incorrect :>" 
                : "Oops! You are not yet connected :<",
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontColor: Theme.of(context).colorScheme.onBackground,
            ),

            SizedBox(height: 2.h),

            MSTextWidget(
              isScanFail 
                ? "Please scan the QR code again to proceed."
                : "Please scan the QR code found in the machine to proceed.",
              fontWeight: FontWeight.w500,
              fontColor: Colors.grey.shade600,
              fontHeight: 2.h,
            ),
          ]
        ),

        const Spacer(),

        MSButtonWidget(
          btnOnTap: btnOnTap,
          btnColor: Theme.of(context).colorScheme.primary,
          child: Center(
            child: MSTextWidget(
              "Connect to Device",
              fontColor: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600
            )
          )
        )
      ],
    );
  }
}