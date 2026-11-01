import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_dimens.dart';
import '../theme/app_colors.dart';

/// WhatsApp support action button with green border and centered icon.
class WhatsAppActionButton extends StatelessWidget {
  const WhatsAppActionButton({
    super.key,
    this.onTap,
    this.size,
    this.iconSize,
    this.radius,
    this.borderWidth,
  });

  final VoidCallback? onTap;
  final double? size;
  final double? iconSize;
  final double? radius;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? AppDimens.whatsappButtonSize;
    final effectiveRadius = radius ?? AppDimens.whatsappButtonRadius;
    final effectiveBorder = borderWidth ?? AppDimens.whatsappButtonBorderWidth;
    final effectiveIcon = iconSize ?? AppDimens.whatsappIconSize;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: effectiveSize,
        height: effectiveSize,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(effectiveRadius),
          border: Border.all(
            color: AppColors.whatsappBorder,
            width: effectiveBorder,
          ),
        ),
        child: Center(
          child: Image.asset(
            AppAssets.whatsappIcon,
            width: effectiveIcon,
            height: effectiveIcon,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
