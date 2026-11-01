import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'rich_link_message.dart';

/// Card with navy header band and white body containing link and illustration.
class LoadNumberCard extends StatelessWidget {
  const LoadNumberCard({
    super.key,
    this.title = AppStrings.loadNumberToCall,
    this.onLinkTapped,
  });

  final String title;
  final VoidCallback? onLinkTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.dashboardCardMargin,
      ),
      child: Stack(
        children: [
          Container(
            height: AppDimens.loadNumberNavyHeight + 16,
            decoration: const BoxDecoration(
              color: AppColors.navyCardBackground,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimens.loadNumberCardRadius),
              ),
            ),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 14),
            child: Text(
              title,
              style: AppTextStyles.loadNumberHeader,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppDimens.loadNumberNavyHeight),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(
                  AppDimens.loadNumberCardRadius,
                ),
                border: Border.all(
                  color: AppColors.cardBorder,
                  width: AppDimens.cardBorderWidth,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.fromLTRB(
                AppDimens.loadNumberHPadding,
                AppDimens.loadNumberHPadding,
                AppDimens.loadNumberHPadding,
                0,
              ),
              child: Column(
                children: [
                  RichLinkMessage(onLinkTapped: onLinkTapped),
                  const SizedBox(height: AppDimens.loadNumberTextToImageGap),
                  Image.asset(
                    AppAssets.callerSupport,
                    width: double.infinity,
                    height: AppDimens.loadNumberImageHeight,
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomLeft,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
