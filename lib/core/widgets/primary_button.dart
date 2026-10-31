import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';

/// Reusable full-width primary button used across all screens.
///
/// [label]       – button text (defaults to [AppStrings.select]).
/// [onPressed]   – callback; pass null to disable the button.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.label = AppStrings.select,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.buttonBorderRadius),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Text(label, style: AppTextStyles.buttonLabel),
      ),
    );
  }
}
