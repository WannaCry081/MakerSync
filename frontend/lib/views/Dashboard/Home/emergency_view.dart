import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/widgets/text_widget.dart';

class EmergencyView extends StatelessWidget {
  const EmergencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){},
          child: Stack(
            children:[
              Container(
                height: 260.h, 
                width: 260.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).brightness == Brightness.dark  
                    ? Colors.grey.shade700
                    : Colors.grey.shade200
                )
              ),
              Positioned.fill(
                child: Center(
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.symmetric(
                        vertical: 70.h,
                        horizontal: 70.w),
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                    ),
                    child: MSTextWidget(
                      "STOP",
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              )
            ]
          ),
        ),

        SizedBox(height: 40.h),

        MSTextWidget(
          "Press the button to initiate an emergency stop of the machine.",
          fontSize: 16.sp,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}