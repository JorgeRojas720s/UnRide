import 'package:flutter/material.dart';
import 'package:un_ride/screens/Widgets/animations/icons/animationIcon.dart';

class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final bool isSelected;

  const AnimatedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.size,
    required this.isSelected,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimationIcons(widget: widget, isSelected: widget.isSelected),
      onPressed: () {
        // setState(() {
        //   isSelected = true;
        // });
        widget.onPressed();
      },
    );
  }
}
