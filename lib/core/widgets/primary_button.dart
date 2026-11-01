import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';

/// Reusable full-width primary button used across all screens.
///
/// [label]       – button text (defaults to [AppStrings.select]).
/// [onPressed]   – callback; pass null to disable the button.
/// [isLoading]   – when true, displays a centred loading spinner.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.label = AppStrings.select,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: isLoading
              ? AppColors.primary
              : AppColors.primary.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.buttonBorderRadius),
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
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.buttonText),
                ),
              )
            : Text(label, style: AppTextStyles.buttonLabel),
      ),
    );
  }
}
