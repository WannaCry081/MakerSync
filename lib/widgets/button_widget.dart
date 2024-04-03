import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";


class MSButtonWidget extends StatefulWidget {
  final Widget? child;
  final double? btnHeight;
  final double? btnWidth;
  final double? btnBorderWidth;
  final double? btnRadius;
  final Color? btnColor;
  final Color? btnBorderColor;
  final void Function()? btnOnTap;

  const MSButtonWidget({
    super.key,
    this.child,
    this.btnHeight,
    this.btnWidth,
    this.btnBorderWidth,
    this.btnRadius,
    this.btnColor,
    this.btnBorderColor,
    this.btnOnTap,
  });

  @override
  State<MSButtonWidget> createState() => _MSButtonWidgetState();
}

class _MSButtonWidgetState extends State<MSButtonWidget> {
  Color? _highlightColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.btnOnTap,
      onTapDown: (_) {
        setState(() {
          _highlightColor = _calculateHighlightColor(widget.btnColor);
        });
      },
      onTapUp: (_) {
        setState(() {
          _highlightColor = null;
        });
      },
      onTapCancel: () {
        setState(() {
          _highlightColor = null;
        });
      },
      child: Container(
        height: widget.btnHeight ?? 50.h,
        width: widget.btnWidth,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.btnBorderColor ?? Colors.transparent,
            width: widget.btnBorderWidth ?? 1.4.w,
          ),
          borderRadius: BorderRadius.circular(widget.btnRadius ?? 8.r),
          color: _highlightColor ?? widget.btnColor,
        ),
        child: Center(child: widget.child),
      ),
    );
  }

  Color? _calculateHighlightColor(Color? color) {
    if (color == null) return null;

    final HSLColor hslColor = HSLColor.fromColor(color);
    final double newLightness = hslColor.lightness + 0.1;

    return hslColor.withLightness(newLightness).toColor();
  }
}
