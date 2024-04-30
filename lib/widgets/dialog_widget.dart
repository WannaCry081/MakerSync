import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/text_widget.dart";

class MSDialogWidget extends StatelessWidget {
  final String dialogTitle;
  final String? dialogSubtitle;
  final Widget? dialogContent;
  final String dialogOption1;
  final String dialogOption2;

  final void Function()? dialogOption1Ontap;
  final void Function()? dialogOption2Ontap;


  const MSDialogWidget({
    Key? key,
    required this.dialogTitle,
    required this.dialogOption1,
    required this.dialogOption2,

    this.dialogSubtitle = "",
    this.dialogContent,
    this.dialogOption2Ontap,
    this.dialogOption1Ontap,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MSTextWidget(
            dialogTitle,
            fontSize: 16.sp,
            fontColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),

          SizedBox(height: 8.h),

          MSTextWidget(
            dialogSubtitle ?? "",
            fontColor: Colors.grey.shade400,
          ),
        ],
      ),
      content: dialogContent, 
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                child: MSButtonWidget(
                  btnOnTap: () {
                    if (dialogOption1Ontap != null) {
                      dialogOption1Ontap!();
                      Navigator.of(context).pop(); // Close dialog
                    }
                  },
                  btnColor: Theme.of(context).colorScheme.primary,
                  btnHeight: 40.h,
                  child: MSTextWidget(
                    dialogOption1,
                    textAlign: TextAlign.center,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          
              SizedBox(width: 8.w),
          
              Flexible(
                child: MSButtonWidget(
                  btnOnTap: () {
                    if (dialogOption2Ontap != null) {
                      dialogOption2Ontap!();
                      Navigator.of(context).pop(); // Close dialog
                    }
                  },
                  btnColor: Theme.of(context).colorScheme.secondary,
                  btnHeight: 40.h,
                  child: MSTextWidget(
                    dialogOption2,
                    textAlign: TextAlign.center,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        
      ]
    );
  }
}