import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/auth_link_text.dart';
import '../providers/otp_provider.dart';

/// Resend OTP link row using [AuthLinkText] with active countdown support.
class ResendRow extends StatelessWidget {
  const ResendRow({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final p = context.watch<OtpProvider>();

    return AuthLinkText(
      prefixText: AppStrings.resendPrompt,
      linkText: p.resendLabel,
      onLinkTap: () {
        if (p.canResend) {
          p.resend(phoneNumber);
        }
      },
    );
  }
}
