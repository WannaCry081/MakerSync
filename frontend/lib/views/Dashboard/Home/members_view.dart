import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/widgets/text_widget.dart';

class MembersView extends StatelessWidget {
  const MembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 15.h),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index){
              return memberCard(
                context: context, 
                name: "John Doe", 
                email: "johndoe@gmail.com"
              );
            }
          ),
        )
      )
    );
  }

  Widget memberCard({
    required BuildContext context,
    required String name,
    required String email
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.5.h),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  "assets/svgs/Logo.svg"
                ),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    height: 12.h,
                    width: 12.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade400
                    ),
                  ),
                )
              ],
            ),

            SizedBox(width: 12.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MSTextWidget(
                  name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontColor: Theme.of(context).colorScheme.onBackground,
                  
                ),
                MSTextWidget(
                  email,
                  fontWeight: FontWeight.w500,
                  fontColor: Colors.grey.shade600,
                  fontHeight: 1.h,
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
