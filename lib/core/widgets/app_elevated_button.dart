import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget? child;
  final String? text;
  final double? borderRadius;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? elevation;
  final OutlinedBorder? circularBorder;
  final Color? textColor;
final double? textSize;
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.borderRadius,
    this.height,
    this.width,
    this.circularBorder,
    this.backgroundColor,
    this.shadowColor,
    this.elevation, this.textColor, this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          circularBorder ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
              ),
        ),
        minimumSize: WidgetStateProperty.all(Size(width ?? 180, height ?? 60)),
        backgroundColor:
            WidgetStateProperty.all(backgroundColor ?? Colors.blue),
        shadowColor: WidgetStateProperty.all(shadowColor ?? Colors.black),
        elevation: WidgetStateProperty.all(elevation ?? 8),
      ),
      child: child ??
          Text(
            text!,
            style:  TextStyle(
              color:textColor ?? Colors.white,
              fontWeight: FontWeight.w700,
              fontSize:textSize?? 25.sp,
            ),
          ),
    );
  }
}
