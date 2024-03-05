import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/widgets/text_widget.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding( 
          padding: EdgeInsets.symmetric(
            vertical: 22.h,
            horizontal: 22.w
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 15.h),

              MSTextWidget(
                "Notifications",
                fontSize: 26.sp,
                fontColor: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              ),

              SizedBox(height: 20.h),

              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index){
                      return notificationCard(
                        context,
                        "Shiela Mae Lepon", 
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam feugiat, quam et sollicitudin pharetra"
                      );
                    }
                  )
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  
  Widget notificationCard(context, name, email) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 7.5.h,
      horizontal: 7.5.w
    ),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme.of(context).colorScheme.tertiary,
        ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/svgs/Logo.svg"),

          SizedBox(width: 12.w),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MSTextWidget(
                  "$name",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontColor: Theme.of(context).colorScheme.onBackground,
                  textOverflow: TextOverflow.ellipsis,
                ),
                MSTextWidget(
                  "$email",
                  fontWeight: FontWeight.w500,
                  fontColor: Colors.grey.shade600,
                  textOverflow: TextOverflow.ellipsis,
                  fontHeight: 1.h,
                )
              ],
            ),
          ),

          MSTextWidget(
            "Feb 15",
            fontSize: 10.sp,
            fontColor: Colors.grey.shade500,
            fontHeight: 2.h,
          )
        ],
      ),
    ),
  );
}

}