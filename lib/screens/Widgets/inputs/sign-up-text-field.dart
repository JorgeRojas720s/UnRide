import 'package:flutter/material.dart';

class SignUpTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Color? fillColor;
  final Color? labelColor;
  final Color? focusedBorderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  const SignUpTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onChanged,
    this.fillColor,
    this.labelColor,
    this.focusedBorderColor,
    this.borderRadius = 10,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final defaultFillColor = fillColor ?? Colors.white.withOpacity(0.05);
    final defaultLabelColor = labelColor ?? Colors.white.withOpacity(0.7);
    final defaultFocusedBorderColor =
        focusedBorderColor ?? Colors.indigo.shade200;
    final defaultContentPadding =
        contentPadding ??
        const EdgeInsets.symmetric(vertical: 16, horizontal: 12);

    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: defaultLabelColor),
        fillColor: defaultFillColor,
        filled: true,
        contentPadding: defaultContentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: defaultFocusedBorderColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.red.shade300, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.red.shade300, width: 1),
        ),
        errorStyle: TextStyle(color: Colors.red.shade300, fontSize: 12),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
