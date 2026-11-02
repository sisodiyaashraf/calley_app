import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/auth_link_text.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/language_provider.dart';
import '../widgets/language_list_card.dart';

/// Screen 1 – "Choose Your Language" with language list and sign-in shortcuts.
class ChooseLanguagePage extends StatelessWidget {
  const ChooseLanguagePage({super.key});

  void _onSelectPressed(BuildContext context) {
    final provider = context.read<LanguageProvider>();
    provider.confirm();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${AppStrings.languageSelectedPrefix}${provider.selectedLanguage.name}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.horizontalMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppDimens.titleTopOffset),
              Text(AppStrings.chooseYourLanguage, style: AppTextStyles.screenTitle, textAlign: TextAlign.center),
              const SizedBox(height: AppDimens.titleToCardGap),
              const LanguageListCard(),
              const SizedBox(height: AppDimens.cardButtonGap),
              PrimaryButton(onPressed: () => _onSelectPressed(context)),
              const SizedBox(height: 12),
              AuthLinkText(
                prefixText: AppStrings.signInPrompt,
                linkText: AppStrings.signInLink,
                onLinkTap: () => Navigator.pushNamed(context, AppRoutes.signIn),
              ),
              const SizedBox(height: AppDimens.buttonBottomMinClearance),
            ],
          ),
        ),
      ),
    );
  }
}
