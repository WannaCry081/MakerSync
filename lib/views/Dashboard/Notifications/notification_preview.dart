import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/views/Dashboard/Notifications/index.dart";
import "package:frontend/widgets/back_button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:frontend/widgets/wrapper_widget.dart";
import "package:intl/intl.dart";


class NotificationPreview extends StatelessWidget {
  final int id;
  final String created;
  final String title;
  final String body;

  const NotificationPreview({
    required this.id,
    required this.created,
    required this.title,
    required this.body
  });

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: MSWrapperWidget(
       child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 22.w,
          vertical: 22.h
        ),

        child: content(
          context: context, 
        ),
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
            btnOnTap: () => Navigator.of(context).pop()
        ),
        
        SizedBox(height: 30.h),

        MSTextWidget(
          created,
          fontColor: Colors.grey.shade400,
        ),

        SizedBox(height: 10.h),
        
        MSTextWidget(
          title,
          fontSize: 26.sp,
          fontColor: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold
        ),
      
        SizedBox(height: 35.h),

        MSTextWidget(
          body,
          fontSize: 16.sp,
          fontColor: Theme.of(context).colorScheme.onBackground,
        ),
      
        SizedBox(height: 15.h),
      ],
    );
  }
}