import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';

class RoleSwitchButton extends StatelessWidget {
  final bool isDriverMode;
  final ValueChanged<bool> onChanged;
  final bool canSwitchToDriver;

  const RoleSwitchButton({
    super.key,
    required this.isDriverMode,
    required this.onChanged,
    required this.canSwitchToDriver,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child:
          canSwitchToDriver
              ? Container(
                key: ValueKey<bool>(canSwitchToDriver),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.scaffoldBackground,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildRoleButton(
                        context,
                        icon: Icons.person_outline,
                        label: 'Client',
                        isActive: !isDriverMode,
                        onTap:
                            () => onChanged(
                              !isDriverMode,
                            ), //!Estaba true por defeault lo cambie pero no se si es lo mejor
                      ),
                      const SizedBox(width: 4),
                      _buildRoleButton(
                        context,
                        icon: Icons.directions_car,
                        label: 'Driver',
                        isActive: isDriverMode,
                        onTap: () => onChanged(isDriverMode),
                        //!Estaba false por defeault lo cambie pero no se si es lo mejor
                      ),
                    ],
                  ),
                ),
              )
              : Container(
                key: ValueKey<bool>(canSwitchToDriver),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, color: AppColors.primary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Client Mode',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildRoleButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textSecondary,
              size: 18,
            ),
            if (isActive) const SizedBox(width: 6),
            if (isActive)
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
