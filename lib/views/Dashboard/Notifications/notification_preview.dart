import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
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

        child: content(),
       )
      )
    );
  }

  Widget content() {
    return Column(
      children: [
        Text("Hello"),
      ],
    );
  }
}