import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../calling_lists/presentation/widgets/calling_lists_sheet.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../../static_screens/domain/entities/static_screen_data.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/settings_row.dart';

/// Screen 7 – Settings page with user summary and profile settings.
class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    this.onAppLanguageTapped,
    this.onChangePasswordTapped,
    this.onCallingListsTapped,
  });

  final VoidCallback? onAppLanguageTapped;
  final VoidCallback? onChangePasswordTapped;
  final VoidCallback? onCallingListsTapped;

  Widget _topBar(BuildContext ctx) => Container(
        height: AppDimens.dashboardAppBarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.maybePop(ctx),
              child: const Icon(Icons.arrow_back_ios_new,
                  size: AppDimens.settingsBackIconSize, color: AppColors.dashboardText),
            ),
            const SizedBox(width: 8),
            Text(AppStrings.settingsTitle, style: AppTextStyles.settingsTitle),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            _topBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileSummaryCard(profile: home.profile),
                    const SizedBox(height: 16),
                    SectionCard(
                      title: AppStrings.profileSettingsBand,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SettingsRow(
                            icon: Icons.language,
                            label: AppStrings.appLanguage,
                            onTap: onAppLanguageTapped ?? () => Navigator.pushNamed(context, AppRoutes.language),
                          ),
                          const SizedBox(height: AppDimens.settingsRowGap),
                          SettingsRow(
                            icon: Icons.lock_outline,
                            label: AppStrings.changePassword,
                            onTap: onChangePasswordTapped ?? () => Navigator.pushNamed(context, AppRoutes.staticScreen, arguments: StaticScreenData.changePassword),
                          ),
                          const SizedBox(height: AppDimens.settingsRowGap),
                          SettingsRow(
                            icon: Icons.list_alt,
                            label: AppStrings.callingLists,
                            onTap: onCallingListsTapped ?? () => CallingListsSheet.show(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
