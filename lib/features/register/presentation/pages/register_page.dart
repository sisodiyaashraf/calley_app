import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/session/session.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/auth_card.dart';
import '../../../../core/widgets/auth_link_text.dart';
import '../../../../core/widgets/logo_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/register_provider.dart';
import '../widgets/register_form.dart';
import '../widgets/terms_checkbox.dart';

/// Screen 2 – "Register" (composes widgets only).
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key, this.onRegistered, this.onSignInTapped});

  final VoidCallback? onRegistered, onSignInTapped;

  Future<void> _submit(BuildContext context) async {
    final p = context.read<RegisterProvider>();
    final ok = await p.submit();
    if (!context.mounted) return;
    if (ok) {
      Session.instance.update(newName: p.name.trim(), newEmail: p.email.trim());
      try { context.read<Session?>()?.update(newName: p.name.trim(), newEmail: p.email.trim()); } catch (_) {}
      final cb = onRegistered ?? p.onRegistered;
      cb != null ? cb() : AppRouter.toOtp(context, p.email.trim());
    } else if (p.generalError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(p.generalError!), backgroundColor: AppColors.errorText));
    }
  }

  Widget _buildCard(BuildContext context) => LayoutBuilder(
        builder: (context, c) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: c.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppStrings.welcome, style: AppTextStyles.cardTitle, textAlign: TextAlign.center),
                  const SizedBox(height: AppDimens.titleSubtitleGap),
                  Text(AppStrings.registerSubtitle, style: AppTextStyles.cardSubtitle, textAlign: TextAlign.center),
                  const SizedBox(height: AppDimens.subtitleToFieldsGap),
                  const RegisterForm(),
                  const SizedBox(height: AppDimens.fieldsToTermsGap),
                  const TermsCheckbox(),
                  const SizedBox(height: AppDimens.termsToSignInGap),
                  AuthLinkText(
                    prefixText: AppStrings.signInPrompt, linkText: AppStrings.signInLink,
                    onLinkTap: () => onSignInTapped != null ? onSignInTapped!() : AppRouter.toSignIn(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
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
              Expanded(child: AuthCard(child: _buildCard(context))),
              const SizedBox(height: AppDimens.cardButtonGap),
              PrimaryButton(
                label: AppStrings.signUp, isLoading: context.watch<RegisterProvider>().isLoading,
                onPressed: () => _submit(context),
              ),
              const SizedBox(height: AppDimens.buttonBottomMinClearance),
            ]),
          ),
        ),
      ),
    );
  }
}
