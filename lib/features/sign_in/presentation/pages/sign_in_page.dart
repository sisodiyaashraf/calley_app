import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/auth_card.dart';
import '../../../../core/widgets/auth_link_text.dart';
import '../../../../core/widgets/logo_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/sign_in_provider.dart';
import '../widgets/sign_in_form.dart';

/// Screen 4 – "Sign In" (composes widgets only).
class SignInPage extends StatelessWidget {
  const SignInPage({
    super.key, this.onSignedIn, this.onForgotPasswordTapped, this.onSignUpTapped,
  });

  final VoidCallback? onSignedIn, onForgotPasswordTapped, onSignUpTapped;

  Future<void> _submit(BuildContext context) async {
    final p = context.read<SignInProvider>();
    final ok = await p.submit();
    if (!context.mounted) return;
    if (ok) {
      onSignedIn != null ? onSignedIn!() : ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.signedInSuccess)));
    } else if (p.generalError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(p.generalError!), backgroundColor: AppColors.errorText));
    }
  }

  void _handleForgot(BuildContext context) => onForgotPasswordTapped != null
      ? onForgotPasswordTapped!()
      : ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.forgotPasswordInfo)));

  Widget _buildCard(BuildContext context) => LayoutBuilder(
        builder: (context, c) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: c.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppStrings.welcomeSignIn,
                      style: AppTextStyles.signInTitle, textAlign: TextAlign.center),
                  const SizedBox(height: AppDimens.signInTitleSubtitleGap),
                  Text(AppStrings.signInSubtitle,
                      style: AppTextStyles.signInSubtitle, textAlign: TextAlign.center),
                  const SizedBox(height: AppDimens.subtitleToFieldsGap),
                  SignInForm(
                    onForgotPassword: () => _handleForgot(context),
                    onSubmit: () => _submit(context),
                  ),
                  const SizedBox(height: AppDimens.signInToSignUpGap),
                  AuthLinkText(
                    prefixText: AppStrings.signUpPrompt, linkText: AppStrings.signUp,
                    style: AppTextStyles.authPrompt, linkStyle: AppTextStyles.authPromptLink,
                    onLinkTap: () => onSignUpTapped != null
                        ? onSignUpTapped!() : AppRouter.toRegisterFromSignIn(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final p = context.watch<SignInProvider>();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.horizontalMargin),
            child: Column(children: [
              const SizedBox(height: AppDimens.logoTopGap),
              const LogoHeader(),
              const SizedBox(height: AppDimens.logoToCardGap),
              Expanded(child: AuthCard(child: _buildCard(context))),
              const SizedBox(height: AppDimens.cardButtonGap),
              PrimaryButton(
                label: AppStrings.signInButton,
                isLoading: p.isLoading,
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
