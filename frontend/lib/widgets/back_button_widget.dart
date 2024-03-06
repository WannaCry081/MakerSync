import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/widgets/button_widget.dart";


class MSBackButtonWidget extends StatelessWidget {

  final void Function()? btnOnTap;
  
  const MSBackButtonWidget({ 
    super.key,
    this.btnOnTap
  });

  @override
  Widget build(BuildContext context){
    return MSButtonWidget(
      btnOnTap: btnOnTap,
      btnWidth : 45.w,
      btnHeight: 45.h,
      btnRadius: 15.r,
      btnBorderColor: Theme.of(context).colorScheme.tertiary,
      child : SvgPicture.asset(
        "assets/icons/LeftArrow.svg",
        height : 20.h,
        width : 20.w,
        // ignore: deprecated_member_use
        color : Theme.of(context).colorScheme.primary,
      )
    );
  }
}