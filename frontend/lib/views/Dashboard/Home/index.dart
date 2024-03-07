import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:frontend/views/Dashboard/Home/emergency_view.dart';
import 'package:frontend/views/Dashboard/Home/members_view.dart';
import 'package:frontend/views/Dashboard/Home/overview_view.dart';
import 'package:frontend/widgets/text_widget.dart';
import 'package:frontend/widgets/wrapper_widget.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = ValueNotifier('Overview');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MSWrapperWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 22.h
          ),

          child: content()
        ),
      )
    );
  }

  Widget content(){
    return Column(
      children: [ 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              SizedBox(height: 15.h),

              MSTextWidget(
                "Hello, Shiela!",
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                fontColor: Theme.of(context).colorScheme.primary
              ),

              SizedBox(height : 5.h),

              const MSTextWidget(
                "Let's start tracking your progress!")
            ],
          ),

          SvgPicture.asset(
              Theme.of(context).brightness == Brightness.dark
              ? "assets/svgs/Logo_DarkMode.svg"
              : "assets/svgs/Logo_LightMode.svg",
              height: 48.h
            )
          ],
        ),

        SizedBox(height: 35.h),

        SizedBox(
          height: 45.h,
          width: MediaQuery.of(context).size.width,
          child: AdvancedSegment(
            controller: _controller,
            segments: const {
              "Overview": "Overview",
              "Members" : "Members",
              "Emergency" : "Emergency",
            },
            activeStyle: const TextStyle(
              fontFamily: "Inter",
              color: Colors.white
            ),
            inactiveStyle: TextStyle(
              fontFamily: "Inter",
              color: Theme.of(context).colorScheme.onBackground
            ),
            sliderOffset: 6,
            sliderDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Theme.of(context).colorScheme.primary
            ),
            backgroundColor: Theme.of(context).colorScheme.tertiary
          )
        ),

        Expanded(
          child: ValueListenableBuilder<String>(
            valueListenable: _controller,
            builder: (_, key, __) {
              switch (key) {
                case "Overview":
                  return const OverviewView();
                case "Members":
                  return const MembersView();
                case "Emergency":
                    return const EmergencyView();
                default:
                  return const OverviewView();
              }
            },
          ),
        ),
      ],
    );
  }
} 