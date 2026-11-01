import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/domain/entities/user_profile.dart';

/// Primary blue card detailing user greeting, email, phone, and tier account.
class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({super.key, this.profile});

  final UserProfile? profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppDimens.profileSummaryHeight,
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.profileSummaryMargin,
      ),
      padding: const EdgeInsets.all(AppDimens.profileSummaryPadding),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppDimens.profileSummaryRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              AppAssets.profileCalley,
              width: AppDimens.homeAvatarSize,
              height: AppDimens.homeAvatarSize,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppStrings.helloPrefix}${profile?.name ?? ""}',
                  style: AppTextStyles.profileSummaryGreeting,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimens.profileSummaryLineGap),
                Text(
                  profile?.email ?? '',
                  style: AppTextStyles.profileSummaryDetail,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimens.profileSummaryLineGap),
                Text(
                  profile?.phone ?? '',
                  style: AppTextStyles.profileSummaryDetail,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimens.profileSummaryLineGap),
                Text(
                  '${AppStrings.parentAccountPrefix}${profile?.parentAccount ?? ""}',
                  style: AppTextStyles.profileSummaryDetail,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimens.profileSummaryLineGap),
                Text(
                  '${AppStrings.subscriptionPrefix}${profile?.subscription ?? ""}',
                  style: AppTextStyles.profileSummaryDetail,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
