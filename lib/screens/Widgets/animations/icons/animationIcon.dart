import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/screens/Widgets/buttons/animated_icon_button.dart';

class AnimationIcons extends StatelessWidget {
  const AnimationIcons({
    super.key,
    required this.widget,
    required this.isSelected,
  });

  final AnimatedIconButton widget;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0.0, -0.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
        );

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: Icon(
        widget.icon,
        key: ValueKey<bool>(isSelected),
        color:
            isSelected ? AppColors.iconsNavBarColor : const Color(0xFF9299A1),
        size: widget.size,
      ),
    );
  }
}
