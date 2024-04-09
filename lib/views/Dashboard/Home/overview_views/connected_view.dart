import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:percent_indicator/circular_percent_indicator.dart";

class ConnectedView extends StatefulWidget {
  final double progressValue;

  const ConnectedView({
    required this.progressValue,
    super.key
  });

  @override
  State<ConnectedView> createState() => _ConnectedViewState();
}

class _ConnectedViewState extends State<ConnectedView> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          SizedBox(height: 15.h),

          CircularPercentIndicator(
            radius: 120.r,
            lineWidth: 35,
            percent: widget.progressValue,
            progressColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            circularStrokeCap: CircularStrokeCap.round,
            center: MSTextWidget(
                "${(widget.progressValue * 100).toInt()}%",
                fontColor : Theme.of(context).colorScheme.onBackground,
                fontSize : 45.sp,
                fontWeight: FontWeight.w500,
              ),
          ),
      
          SizedBox(height: 20.h),
      
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(10.r)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svgs/Thermometer.svg"
                  ),

                  SizedBox(width: 10.w),
                  
                  MSTextWidget(
                    "230°C",
                    fontColor: Theme.of(context).colorScheme.onBackground,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                  )
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}