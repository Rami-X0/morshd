import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final double? elevation;
  final Color? shadowColor;
  final bool? obscureText;
  final Function(String?) validator;
  final TextEditingController? controller;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final void Function()? onTap;

  const AppTextFormField({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    this.contentPadding,
    this.obscureText,
    required this.validator,
    required this.controller,
    this.fillColor,
    this.borderRadius,
    this.elevation,
    this.shadowColor,
    this.keyboardType, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap:onTap ,
      keyboardType: keyboardType,
      validator: (value) {
        return validator(value);
      },
      controller: controller,
      obscureText: obscureText ?? false,
      cursorOpacityAnimates: true,
      decoration: _textFormFiledDecoration(),
    );
  }

  InputDecoration _textFormFiledDecoration() {
    return InputDecoration(
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            vertical: 17,
            horizontal: 20,
          ),
      hintText: hintText,
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.3,
        ),
      ),
      focusedBorder:  UnderlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 1.3,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.3,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        borderSide: const BorderSide(color: Colors.red, width: 1.3),
      ),
      suffixIcon: suffixIcon,
      isDense: true,
      filled: true,
      fillColor: fillColor ?? Colors.white,
    );
  }
}
