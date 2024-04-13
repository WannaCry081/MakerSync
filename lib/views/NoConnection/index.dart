import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:frontend/widgets/wrapper_widget.dart";

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MSWrapperWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 22.h,
          ),
          
          child: content(),
        ),
      )
    );
  }

  Widget content() {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/svgs/NoConnection.svg"
            )
          )
        ],
      )
    );
  }
}