import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Reusable card with navy title band and overlapping white rounded body.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    this.titleStyle,
    this.bandHeight = AppDimens.profileSettingsBandHeight,
    this.topRadius = 20.0,
    this.bodyRadius = 20.0,
    this.margin,
    this.padding = const EdgeInsets.all(16.0),
  });

  final String title;
  final Widget child;
  final TextStyle? titleStyle;
  final double bandHeight;
  final double topRadius;
  final double bodyRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = titleStyle ?? AppTextStyles.profileSettingsBand;

    return Container(
      margin: margin,
      child: Stack(
        children: [
          Container(
            height: bandHeight + 16,
            decoration: BoxDecoration(
              color: AppColors.navyCardBackground,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(topRadius),
              ),
            ),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              title,
              style: effectiveStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: bandHeight),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(bodyRadius),
                border: Border.all(
                  color: AppColors.cardBorder,
                  width: AppDimens.cardBorderWidth,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              padding: padding,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
