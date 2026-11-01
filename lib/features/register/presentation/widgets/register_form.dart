import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/register_provider.dart';

/// The 5 form fields for the Register screen.
class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<RegisterProvider>();

    return Column(
      children: [
        AppTextField(
          hint: AppStrings.hintName,
          errorText: p.nameError,
          onChanged: p.setName,
          keyboardType: TextInputType.name,
          trailingIcon: const Icon(
            Icons.person_outline,
            size: AppDimens.fieldIconSize,
            color: AppColors.fieldIcon,
          ),
        ),
        const SizedBox(height: AppDimens.fieldGap),
        AppTextField(
          hint: AppStrings.hintEmail,
          errorText: p.emailError,
          onChanged: p.setEmail,
          keyboardType: TextInputType.emailAddress,
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
        ),
        const SizedBox(height: AppDimens.fieldGap),
        AppTextField(
          hint: AppStrings.hintCountryCode,
          initialValue: AppStrings.countryCodeIndia,
          readOnly: true,
          trailingIcon: const Center(
            widthFactor: 1.0,
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              size: AppDimens.fieldIconSize,
              color: AppColors.fieldIcon,
            ),
          ),
        ),
        const SizedBox(height: AppDimens.fieldGap),
        AppTextField(
          hint: AppStrings.hintMobile,
          errorText: p.phoneError,
          onChanged: p.setPhone,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          trailingIcon: const Icon(
            Icons.phone_outlined,
            size: AppDimens.fieldIconSize,
            color: AppColors.fieldIcon,
          ),
        ),
      ],
    );
  }
}
