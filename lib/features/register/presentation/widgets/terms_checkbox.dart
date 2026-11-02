import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/register_provider.dart';

/// 16px square checkbox with Terms and Conditions link and error text.
class TermsCheckbox extends StatefulWidget {
  const TermsCheckbox({super.key, this.onTermsTap});
  final VoidCallback? onTermsTap;

  @override
  State<TermsCheckbox> createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  late final TapGestureRecognizer _linkRecognizer;

  @override
  void initState() {
    super.initState();
    _linkRecognizer = TapGestureRecognizer()
      ..onTap = () => widget.onTermsTap != null ? widget.onTermsTap!() : context.read<RegisterProvider>().toggleTerms();
  }

  @override
  void dispose() {
    _linkRecognizer.dispose();
    super.dispose();
  }

  Widget _box(RegisterProvider p) => GestureDetector(
        onTap: p.toggleTerms,
        child: Container(
          width: AppDimens.checkboxSize, height: AppDimens.checkboxSize,
          decoration: BoxDecoration(
            color: p.agreedToTerms ? AppColors.checkboxChecked : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppDimens.checkboxRadius),
            border: Border.all(
              color: p.agreedToTerms ? AppColors.checkboxChecked : AppColors.checkboxBorder,
              width: AppDimens.checkboxBorderWidth,
            ),
          ),
          child: p.agreedToTerms ? const Icon(Icons.check, size: 12, color: AppColors.buttonText) : null,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final p = context.watch<RegisterProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            _box(p),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.termsText,
                  children: [
                    TextSpan(text: AppStrings.termsPrefix, recognizer: TapGestureRecognizer()..onTap = p.toggleTerms),
                    TextSpan(text: AppStrings.termsLink, style: AppTextStyles.termsLink, recognizer: _linkRecognizer),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (p.termsError != null) ...[
          const SizedBox(height: 4),
          Text(p.termsError!, style: AppTextStyles.termsText.copyWith(color: AppColors.errorText)),
        ],
      ],
    );
  }
}
