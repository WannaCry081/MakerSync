import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/widgets/text_widget.dart";


class MSSnackbarWidget extends StatelessWidget {
  final String message;

  const MSSnackbarWidget({
    super.key,
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }

   void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MSTextWidget(message),
        duration: const Duration(milliseconds: 2000),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r)),
        action: SnackBarAction(
          label: "Close",
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      )
    );
  }
}
