import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/views/Dashboard/Notifications/index.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";


class NotificationPreview extends StatelessWidget {
  const NotificationPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MSWrapperWidget(
       child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 22.w,
          vertical: 22.h
        ),

        child: content(context: context),
       )
      )
    );
  }

  Widget content({
    required BuildContext context
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MSBackButtonWidget(
            btnOnTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NotificationsView()
              )
            )
        ),
        
        SizedBox(height: 30.h),

        MSTextWidget(
          "July 10, 2024 | 9:10AM",
          fontColor: Colors.grey.shade400,
        ),

        SizedBox(height: 10.h),
        
        MSTextWidget(
          "Petamentor's emergency stop has been activated.",
          fontSize: 26.sp,
          fontColor: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold
        ),
      
        SizedBox(height: 35.h),

        MSTextWidget(
          "Someone has pressed the emergency button. Petamentor has stopped.",
          fontSize: 16.sp,
          fontColor: Theme.of(context).colorScheme.onBackground,
        ),
      
        SizedBox(height: 15.h),
      ],
    );
  }
}