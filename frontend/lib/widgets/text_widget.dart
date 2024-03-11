import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";


class MSTextWidget extends StatelessWidget {

  final String text;
  final TextAlign ? textAlign;
  final TextOverflow ? textOverflow;
  final TextDecoration ? textDecoration;
  final double ? fontSize;
  final double ? fontHeight;
  final Color ? fontColor;
  final FontWeight ? fontWeight;

  const MSTextWidget(
    this.text, { 
      super.key,
      this.textAlign,
      this.textDecoration,
      this.textOverflow,
      this.fontSize,
      this.fontHeight,
      this.fontColor,
      this.fontWeight
  });

  @override
  Widget build(BuildContext context){
    return Text(
      text,
      softWrap: true,
      textAlign: textAlign,
      style : TextStyle(
        fontFamily : "Inter",
        fontSize : fontSize ?? 10.sp,
        fontWeight: fontWeight,
        height: fontHeight,
        color : fontColor,
        decoration: textDecoration
      ),
      overflow: textOverflow,
    );
  }
}