import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:frontend/widgets/button_widget.dart";
import "package:frontend/widgets/text_widget.dart";
import "package:percent_indicator/circular_percent_indicator.dart";


class OverviewView extends StatefulWidget {
  const OverviewView({ super.key });

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  bool _isConnected = false;
  double _progressValue = 0.4;

  @override
  Widget build(BuildContext context){
    return Scaffold( 
      body : Center(
        child: _isConnected ? connectedView() : disconnectedView(),
      )
    );
  }

  Widget connectedView() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 120.r,
            lineWidth: 35,
            percent: _progressValue,
            progressColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            circularStrokeCap: CircularStrokeCap.round,
            center: MSTextWidget(
                "${(_progressValue * 100).toInt()}%",
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

  Widget disconnectedView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25.w),
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/svgs/Blob2.svg", 
                // ignore: deprecated_member_use
                color: Theme.of(context).brightness == Brightness.dark 
                  ? Theme.of(context).colorScheme.primary
                  : null,
              ),
              Positioned.fill(
                child: Center(
                  child: SvgPicture.asset(
                    "assets/svgs/Search.svg", 
                    height: 400.h
                  ),
                ),
              ),
            ]
          ),
        ),
        
        SizedBox(height: 10.h),

        Column(
          children: [
            MSTextWidget(
              "Oops! You are not yet connected :<",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontColor: Theme.of(context).colorScheme.onBackground,
            ),
            MSTextWidget(
              "Please scan the QR code found in the machine to proceed.",
              fontWeight: FontWeight.w500,
              fontColor: Colors.grey.shade600,
              fontHeight: 2.h,
            ),
          ]
        ),

        const Spacer(),

        MSButtonWidget(
          btnOnTap: (){
            setState(() => _isConnected = true);
          },
          btnColor: Theme.of(context).colorScheme.primary,
          child: Center(
            child: MSTextWidget(
              "Connect to Device",
              fontColor: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600
            )
          )
        )
      ],
    );
  }
}