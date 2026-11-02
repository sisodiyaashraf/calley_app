import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/static_screen_data.dart';

/// Renders a dedicated static content screen with top navigation and details.
class StaticScreenPage extends StatelessWidget {
  const StaticScreenPage({super.key, this.data});

  final StaticScreenData? data;

  Widget _topBar(BuildContext ctx, String title) => Container(
        height: AppDimens.dashboardAppBarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.maybePop(ctx),
              child: const Icon(Icons.arrow_back_ios_new, size: AppDimens.settingsBackIconSize, color: AppColors.dashboardText),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: AppTextStyles.settingsTitle, overflow: TextOverflow.ellipsis)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final info = data ?? StaticScreenData.gettingStarted;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            _topBar(context, info.title),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.horizontalMargin, vertical: 20),
                child: Column(
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(color: AppColors.cardBackground, shape: BoxShape.circle, border: Border.all(color: AppColors.cardBorder, width: 1.5)),
                      child: Icon(info.icon, size: 40, color: AppColors.primary),
                    ),
                    const SizedBox(height: 20),
                    Text(info.title, style: AppTextStyles.cardTitle, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text(info.subtitle, style: AppTextStyles.cardSubtitle, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.cardBorder)),
                      child: Text(info.description, style: AppTextStyles.richLinkBody, textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.horizontalMargin),
              child: PrimaryButton(label: info.actionLabel, onPressed: () => Navigator.maybePop(context)),
            ),
          ],
        ),
      ),
    );
  }
}
