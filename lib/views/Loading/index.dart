import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:frontend/widgets/wrapper_widget.dart";

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MSWrapperWidget(
        child: MSWrapperWidget(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 22.w,
              vertical: 22.h,
            ),
            
            child: content(context),
          ),
        )
      )
    );
  }

  Widget content(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCube(
          color: Theme.of(context).colorScheme.secondary,
          size: 60.h,
        )
      )
    );
  }
}