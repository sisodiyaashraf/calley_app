import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';
import '../theme/app_colors.dart';

/// 24x24 rounded square button with a 1.5px black border and trailing arrow.
class ArrowBoxButton extends StatelessWidget {
  const ArrowBoxButton({
    super.key,
    this.onTap,
    this.icon = Icons.arrow_forward_ios,
  });

  final VoidCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.arrowBoxRadius),
      child: Container(
        width: AppDimens.arrowBoxSize,
        height: AppDimens.arrowBoxSize,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimens.arrowBoxRadius),
          border: Border.all(
            color: AppColors.titleText,
            width: AppDimens.arrowBoxBorderWidth,
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 11.0,
          color: AppColors.titleText,
        ),
      ),
    );
  }
}
