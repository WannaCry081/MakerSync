import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";


class MSTextFieldWidget extends StatefulWidget {

  final TextEditingController? controller;
  final double? fieldHeight;
  final double? fieldWidth;
  final double? fieldRadius;
  final double? fieldBorderWidth;
  final Color? fieldBackground;
  final Color? fieldBorderColor;
  final bool fieldIsObsecure;
  final bool fieldIsValid;
  final bool? fieldIsReadOnly;
  final String? fieldLabelText;
  final Color? fieldLabelColor;
  final String? Function(String?)? fieldValidator;
  final void Function(String?)? fieldOnChanged;
  
  const MSTextFieldWidget({
    super.key,
    this.controller,
    this.fieldHeight,
    this.fieldWidth,
    this.fieldRadius, 
    this.fieldBorderWidth,
    this.fieldBackground,
    this.fieldBorderColor,
    this.fieldIsObsecure = false,
    this.fieldLabelText,
    this.fieldLabelColor,
    this.fieldValidator,
    this.fieldIsValid = false,
    this.fieldIsReadOnly = false,
    this.fieldOnChanged
  });

  @override
  State<MSTextFieldWidget> createState() => _MSTextFieldWidgetState();
}


class _MSTextFieldWidgetState extends State<MSTextFieldWidget> {

  bool _showPassword = false;
  
  @override
  Widget build(BuildContext context){
    return Container(
      height : widget.fieldHeight ?? 50.h,
      width : widget.fieldWidth,
      padding: EdgeInsets.only(
        left: 15.w,
        right: (widget.fieldIsObsecure)
          ? 10.w
          : 15.w,
      ),
      decoration: BoxDecoration(
        color : widget.fieldBackground,
        borderRadius: BorderRadius.circular(widget.fieldRadius ?? 10.r),
        border : Border.all(
          color : widget.fieldIsValid 
            ? widget.fieldBorderColor ?? Colors.transparent
            : Colors.red,
          width : widget.fieldBorderWidth ?? 1.4.w
        )
      ),
      child: Center(
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: widget.controller,
                onChanged: widget.fieldOnChanged,
                validator: widget.fieldValidator,
                readOnly: widget.fieldIsReadOnly!,
                obscureText: (widget.fieldIsObsecure && !_showPassword),
                style: TextStyle(
                  fontFamily : "Inter",
                  fontSize : 16.sp,
                ),     
                decoration: InputDecoration(
                  labelText: widget.fieldLabelText,
                  labelStyle: TextStyle(
                    fontFamily: "Inter",
                    fontSize : 10.sp,
                    color : widget.fieldLabelColor
                  ),
                  border : InputBorder.none,
                ),
              ),
            ),

            if (widget.fieldIsObsecure)
              IconButton(
                icon : (_showPassword) 
                  ? const Icon(FeatherIcons.eyeOff) 
                  : const Icon(FeatherIcons.eye),
                onPressed: () => setState(
                  () => _showPassword = !_showPassword),
              ),
          ],
        ),
      ),
    );
  }
}