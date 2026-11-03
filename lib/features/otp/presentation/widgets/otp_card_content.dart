import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/otp_input_row.dart';
import '../providers/otp_provider.dart';
import 'otp_header_text.dart';
import 'resend_row.dart';

/// Card content composing OTP header, boxes, email display, and resend row.
class OtpCardContent extends StatelessWidget {
  const OtpCardContent({super.key, required this.identity});

  final String identity;

  @override
  Widget build(BuildContext context) {
    final p = context.watch<OtpProvider>();
    return Center(
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const OtpHeaderText(),
          const SizedBox(height: 20),
          OtpInputRow(code: p.code, hasError: p.error != null, onChanged: p.setCode),
          if (p.error != null) ...[
            const SizedBox(height: 6),
            Text(p.error!, style: AppTextStyles.termsText.copyWith(color: AppColors.errorText), textAlign: TextAlign.center),
          ],
          const SizedBox(height: 16),
          Text(identity, style: AppTextStyles.otpPhone, textAlign: TextAlign.center),
          const SizedBox(height: 18),
          ResendRow(email: identity),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => Navigator.maybePop(context),
            child: Text.rich(TextSpan(style: AppTextStyles.termsText, children: [
              const TextSpan(text: AppStrings.wrongNumberPrompt),
              TextSpan(text: AppStrings.changeNumberLink, style: AppTextStyles.termsLink),
            ]), textAlign: TextAlign.center),
          ),
        ]),
      ),
    );
  }
}
