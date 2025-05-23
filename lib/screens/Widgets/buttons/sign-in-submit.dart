import 'package:flutter/material.dart';

class SignInSubmitButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final List<Color>? gradientColors;
  final Color? shadowColor;
  final BorderRadius? borderRadius;

  const SignInSubmitButton({
    super.key,
    required this.isLoading,
    required this.text,
    required this.onPressed,
    this.height = 54,
    this.gradientColors,
    this.shadowColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final defaultGradientColors =
        gradientColors ?? [const Color(0xFF5C5CFF), const Color(0xFF7C4DFF)];
    final defaultShadowColor =
        shadowColor ?? const Color(0xFF5C5CFF).withOpacity(0.4);
    final defaultBorderRadius = borderRadius ?? BorderRadius.circular(30);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: height,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        gradient: LinearGradient(
          colors: defaultGradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: defaultShadowColor,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
        ),
        child:
            isLoading
                ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
                : Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
      ),
    );
  }
}
