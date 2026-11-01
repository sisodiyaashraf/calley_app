import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';
import '../theme/app_colors.dart';

/// 36x36 rounded square with 1px #CBD5E1 border housing an icon.
class IconBox extends StatelessWidget {
  const IconBox({
    super.key,
    required this.icon,
    this.iconSize = 20.0,
    this.iconColor = AppColors.titleText,
  });

  final IconData icon;
  final double iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.iconBoxSize,
      height: AppDimens.iconBoxSize,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.iconBoxRadius),
        border: Border.all(
          color: AppColors.cardBorder,
          width: AppDimens.cardBorderWidth,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}
