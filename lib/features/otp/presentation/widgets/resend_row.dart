import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/auth_link_text.dart';
import '../providers/otp_provider.dart';

/// Resend OTP link row using [AuthLinkText] with active countdown support.
class ResendRow extends StatelessWidget {
  const ResendRow({super.key, this.email = '', this.phoneNumber});

  final String email;
  final String? phoneNumber;

  String get target => email.isNotEmpty ? email : (phoneNumber ?? '');

  @override
  Widget build(BuildContext context) {
    final p = context.watch<OtpProvider>();

    return AuthLinkText(
      prefixText: AppStrings.resendPrompt,
      linkText: p.resendLabel,
      onLinkTap: () {
        if (p.canResend) {
          p.resend(target);
        }
      },
    );
  }
}
