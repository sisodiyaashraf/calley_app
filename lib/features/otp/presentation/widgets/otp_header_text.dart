import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Centred OTP header containing the two-line title and description.
class OtpHeaderText extends StatelessWidget {
  const OtpHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppStrings.otpTitle,
          style: AppTextStyles.otpTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.otpTitleToDescGap),
        Text(
          AppStrings.otpDescription,
          style: AppTextStyles.otpDescription,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
