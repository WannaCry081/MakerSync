import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/widgets/text_widget.dart";

class DisconnectedViewWidget extends StatelessWidget {
  const DisconnectedViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MSTextWidget(
            "Oops! You are not yet connected :<",
            textAlign: TextAlign.center,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontColor: Theme.of(context).colorScheme.onBackground,
          ),

          SizedBox(height: 4.h),

          MSTextWidget(
            "Please connect to the device and finish initializing the machine.",
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            fontColor: Colors.grey.shade600,
            fontHeight: 2.h,
          ),
        ]
      ),
    );
  }
}