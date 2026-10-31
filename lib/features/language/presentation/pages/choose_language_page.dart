import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/language_provider.dart';
import '../widgets/language_list_card.dart';

/// Screen 1 – "Choose Your Language".
///
/// The card sizes to its content (a Column of 9 tiles) so all options are
/// visible at once. A [SingleChildScrollView] activates only on very small
/// screens, ensuring no overflow errors.
/// [onLanguageConfirmed] is left as a clearly marked hook for navigation
/// to the Register screen (Screen 2) – wired in app.dart / the provider.
class ChooseLanguagePage extends StatelessWidget {
  const ChooseLanguagePage({super.key});

  void _onSelectPressed(BuildContext context) {
    final provider = context.read<LanguageProvider>();
    provider.confirm();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${AppStrings.languageSelectedPrefix}${provider.selectedLanguage.name}',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.horizontalMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Title ─────────────────────────────────────────────────
              const SizedBox(height: AppDimens.titleTopOffset),
              Text(
                AppStrings.chooseYourLanguage,
                style: AppTextStyles.screenTitle,
                textAlign: TextAlign.center,
              ),
              // ── Tight gap between title and card ──────────────────────
              const SizedBox(height: AppDimens.titleToCardGap),
              // ── Card (sizes to content – all rows visible at once) ────
              const LanguageListCard(),
              // ── Gap between card and button ───────────────────────────
              const SizedBox(height: AppDimens.cardButtonGap),
              // ── Select button ─────────────────────────────────────────
              PrimaryButton(
                onPressed: () => _onSelectPressed(context),
              ),
              // ── Bottom clearance above safe-area edge ─────────────────
              const SizedBox(height: AppDimens.buttonBottomMinClearance),
            ],
          ),
        ),
      ),
    );
  }
}
