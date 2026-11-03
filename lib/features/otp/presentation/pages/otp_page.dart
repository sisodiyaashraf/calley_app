import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/session/pending_registration.dart';
import '../../../../core/session/session.dart';
import '../../../../core/session/session_storage.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/auth_card.dart';
import '../../../../core/widgets/logo_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../sign_in/domain/usecases/login_user.dart';
import '../providers/otp_provider.dart';
import '../widgets/otp_card_content.dart';

/// Screen 3 – "WhatsApp OTP Verification" with full navigation and verify actions.
class OtpPage extends StatelessWidget {
  const OtpPage({super.key, this.email = '', this.phoneNumber, this.onVerified});

  final String email;
  final String? phoneNumber;
  final VoidCallback? onVerified;

  String get identity => email.isNotEmpty ? email : (phoneNumber ?? '');

  Future<void> _handleVerify(BuildContext context) async {
    final p = context.read<OtpProvider>();
    final ok = await p.verify(identity);
    if (!context.mounted || !ok) return;

    final pEmail = PendingRegistration.email ?? identity, pPass = PendingRegistration.password;
    LoginUser? loginUser;
    try { loginUser = context.read<LoginUser?>(); } catch (_) {}

    if (loginUser != null && pPass != null && pPass.isNotEmpty) {
      try {
        final user = await loginUser(pEmail, pPass);
        if (!context.mounted) return;
        Session.instance.update(newUserId: user.id, newName: user.username, newEmail: user.email);
        try { context.read<Session?>()?.update(newUserId: user.id, newName: user.username, newEmail: user.email); } catch (_) {}
        await SessionStorage.save(user.username, user.email, user.id);
        PendingRegistration.clear();
      } on AppException catch (e) {
        p.setError(e.message); return;
      } catch (_) {
        p.setError(AppStrings.errGeneric); return;
      }
    } else {
      final s = Session.instance;
      await SessionStorage.save(s.name, s.email, s.userId);
      PendingRegistration.clear();
    }
    if (!context.mounted) return;
    final cb = onVerified ?? p.onVerified;
    cb != null ? cb() : AppRouter.toHome(context);
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
              Align(alignment: Alignment.centerLeft, child: IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.dashboardText), onPressed: () => Navigator.maybePop(context))),
              const LogoHeader(),
              const SizedBox(height: 8),
              Expanded(child: AuthCard(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14), child: OtpCardContent(identity: identity))),
              const SizedBox(height: 10),
              PrimaryButton(label: AppStrings.verify, isLoading: p.isLoading, onPressed: p.isComplete ? () => _handleVerify(context) : null),
              const SizedBox(height: 8),
              InkWell(onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.signIn), child: Text.rich(TextSpan(style: AppTextStyles.authPrompt, children: [const TextSpan(text: AppStrings.signInPrompt), TextSpan(text: AppStrings.signInLink, style: AppTextStyles.authPromptLink)]), textAlign: TextAlign.center)),
              const SizedBox(height: 10),
            ]),
          ),
        ),
      ),
    );
  }
}
