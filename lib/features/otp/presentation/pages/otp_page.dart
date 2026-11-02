import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/auth_card.dart';
import '../../../../core/widgets/logo_header.dart';
import '../../../../core/widgets/otp_input_row.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/otp_provider.dart';
import '../widgets/otp_header_text.dart';
import '../widgets/resend_row.dart';

/// Screen 3 – "WhatsApp OTP Verification" with full navigation and verify actions.
class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.phoneNumber, this.onVerified});

  final String phoneNumber;
  final VoidCallback? onVerified;

  Future<void> _handleVerify(BuildContext context) async {
    final p = context.read<OtpProvider>();
    final ok = await p.verify(phoneNumber);
    if (!context.mounted || !ok) return;
    final cb = onVerified ?? p.onVerified;
    cb != null ? cb() : AppRouter.toHome(context);
  }

  Widget _buildCard(BuildContext context) {
    final p = context.watch<OtpProvider>();
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const OtpHeaderText(),
        const SizedBox(height: AppDimens.otpDescToInputGap),
        OtpInputRow(code: p.code, hasError: p.error != null, onChanged: p.setCode),
        if (p.error != null) ...[
          const SizedBox(height: 8),
          Text(p.error!, style: AppTextStyles.termsText.copyWith(color: AppColors.errorText), textAlign: TextAlign.center),
        ],
        const SizedBox(height: AppDimens.otpInputToPhoneGap),
        Text(phoneNumber, style: AppTextStyles.otpPhone, textAlign: TextAlign.center),
        const SizedBox(height: AppDimens.otpPhoneToResendGap),
        ResendRow(phoneNumber: phoneNumber),
        const SizedBox(height: 12),
        InkWell(
          onTap: () => Navigator.maybePop(context),
          child: Text.rich(TextSpan(style: AppTextStyles.termsText, children: [
            const TextSpan(text: AppStrings.wrongNumberPrompt),
            TextSpan(text: AppStrings.changeNumberLink, style: AppTextStyles.termsLink),
          ]), textAlign: TextAlign.center),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<OtpProvider>();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.horizontalMargin),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.dashboardText),
                  onPressed: () => Navigator.maybePop(context),
                ),
              ),
              const LogoHeader(),
              const SizedBox(height: 12),
              Expanded(child: AuthCard(padding: const EdgeInsets.all(AppDimens.otpCardPadding), child: _buildCard(context))),
              const SizedBox(height: 12),
              PrimaryButton(label: AppStrings.verify, isLoading: p.isLoading, onPressed: p.isComplete ? () => _handleVerify(context) : null),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.signIn),
                child: Text.rich(TextSpan(style: AppTextStyles.authPrompt, children: [
                  const TextSpan(text: AppStrings.signInPrompt),
                  TextSpan(text: AppStrings.signInLink, style: AppTextStyles.authPromptLink),
                ]), textAlign: TextAlign.center),
              ),
              const SizedBox(height: 12),
            ]),
          ),
        ),
      ),
    );
  }
}
