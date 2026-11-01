import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'video_thumbnail.dart';

/// Dark navy card containing the first-time onboarding text and video thumbnail.
class FirstTimeInfoCard extends StatelessWidget {
  const FirstTimeInfoCard({super.key, this.onVideoTapped});

  final VoidCallback? onVideoTapped;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.homeInfoCardRadius),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.navyCardBackground,
          borderRadius: BorderRadius.circular(AppDimens.homeInfoCardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                AppStrings.homeInfoNotice,
                style: AppTextStyles.homeInfoText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppDimens.homeInfoTextToVideoGap),
            VideoThumbnail(onTap: onVideoTapped),
          ],
        ),
      ),
    );
  }
}
