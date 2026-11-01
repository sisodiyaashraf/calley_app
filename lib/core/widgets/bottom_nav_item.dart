import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';
import '../theme/app_colors.dart';

/// Single interactive item in the bottom navigation bar with animated pill.
class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.bottomNavPillRadius),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: AppDimens.bottomNavPillWidth,
        height: AppDimens.bottomNavPillHeight,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimens.bottomNavPillRadius),
        ),
        child: Center(
          child: Icon(
            icon,
            size: AppDimens.bottomNavIconSize,
            color: isSelected ? AppColors.whiteText : AppColors.bottomNavInactive,
          ),
        ),
      ),
    );
  }
}
