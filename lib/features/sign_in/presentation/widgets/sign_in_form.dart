import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/sign_in_provider.dart';

/// Form with Email, Password, and "Forgot Password?" link.
class SignInForm extends StatelessWidget {
  const SignInForm({super.key, this.onForgotPassword, this.onSubmit});

  final VoidCallback? onForgotPassword;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    final p = context.watch<SignInProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          hint: AppStrings.hintEmail,
          errorText: p.emailError,
          onChanged: p.setEmail,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          trailingIcon: const Icon(
            Icons.mail_outline,
            size: AppDimens.fieldIconSize,
            color: AppColors.fieldIcon,
          ),
        ),
        const SizedBox(height: AppDimens.fieldGap),
        AppTextField(
          hint: AppStrings.hintPassword,
          errorText: p.passwordError,
          obscureText: true,
          onChanged: p.setPassword,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => onSubmit?.call(),
        ),
        const SizedBox(height: AppDimens.forgotPasswordTopGap),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: onForgotPassword,
            child: Text(
              AppStrings.forgotPassword,
              style: AppTextStyles.forgotPassword,
            ),
          ),
        ),
      ],
    );
  }
}
