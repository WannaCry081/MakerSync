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
    return TextFormField(
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
        filled: true,
        fillColor: widget.fieldBackground,
        labelText: widget.fieldLabelText,
        labelStyle: TextStyle(
          fontFamily: "Inter",
          fontSize : 10.sp,
          color : widget.fieldLabelColor
        ),
        suffixIcon: (widget.fieldIsObsecure)
          ? IconButton(
            icon: (_showPassword)
              ? const Icon(FeatherIcons.eyeOff)
              : const Icon(FeatherIcons.eye),
            onPressed: () => setState(
              () => _showPassword = !_showPassword)
            )
          : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.fieldRadius ?? 10.r),
          borderSide: BorderSide(
            color: widget.fieldBorderColor!,
            width : widget.fieldBorderWidth ?? 1.4.w
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.fieldRadius ?? 10.r),
          borderSide: BorderSide(
            color: widget.fieldBorderColor!,
            width : widget.fieldBorderWidth ?? 1.4.w
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red.shade200,
            width : widget.fieldBorderWidth ?? 1.4.w
          )),
        ),
    );
  }
}