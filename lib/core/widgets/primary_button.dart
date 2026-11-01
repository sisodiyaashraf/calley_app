import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';

/// Reusable full-width primary button used across all screens.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.label = AppStrings.select,
    required this.onPressed,
    this.isLoading = false,
    this.height,
    this.radius,
    this.textStyle,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? height;
  final double? radius;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? AppDimens.buttonHeight;
    final effectiveRadius = radius ?? AppDimens.buttonBorderRadius;
    final effectiveStyle = textStyle ?? AppTextStyles.buttonLabel;

    return SizedBox(
      height: effectiveHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: isLoading
              ? AppColors.primary
              : AppColors.primary.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveRadius),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.buttonText),
                ),
              )
            : Text(label, style: effectiveStyle),
      ),
    );
  }
}
