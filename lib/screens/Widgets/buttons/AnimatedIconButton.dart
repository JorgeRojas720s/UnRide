import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';

class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  const AnimatedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.size,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder:
            (child, animation) =>
                ScaleTransition(scale: animation, child: child),
        child: Icon(
          widget.icon,
          key: ValueKey<bool>(isSelected),
          color:
              isSelected ? AppColors.iconsNavBarColor : const Color(0xFF9299A1),
          size: widget.size,
        ),
      ),
      onPressed: () {
        setState(() {
          isSelected = true;
        });
        widget.onPressed();
      },
    );
  }
}
