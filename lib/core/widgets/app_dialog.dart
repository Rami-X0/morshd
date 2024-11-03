import 'dart:ui';

import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final Widget child;
  final double height;
  final double? width;
  final Color? color;

  const AppDialog({
    super.key,
    required this.child,
    required this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        insetPadding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          color: color ?? Colors.white,
          height: height,
          width: width ?? double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: child,
        ),
      ),
    );
  }
}
