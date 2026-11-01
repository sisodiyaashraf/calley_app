import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_dimens.dart';

/// Shared white auth card (radius 20, 1 px #CBD5E1 border, shadow).
class AuthCard extends StatelessWidget {
  const AuthCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.cardBorderRadius),
        border: Border.all(
          color: AppColors.cardBorder,
          width: AppDimens.cardBorderWidth,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            offset: Offset(0, AppDimens.cardShadowOffsetY),
            blurRadius: AppDimens.cardShadowBlur,
          ),
        ],
      ),
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: AppDimens.authCardHPadding,
              vertical: AppDimens.authCardVPadding,
            ),
        child: child,
      ),
    );
  }
}
