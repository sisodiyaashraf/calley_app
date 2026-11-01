import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../../features/home/domain/entities/user_profile.dart';

/// Blue profile header displaying user avatar, greeting, and tier title.
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    this.profile,
    this.greeting,
    this.title,
    this.greetingStyle,
    this.titleStyle,
    this.margin,
    this.radius,
    this.height,
  });

  final UserProfile? profile;
  final String? greeting;
  final String? title;
  final TextStyle? greetingStyle;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? margin;
  final double? radius;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final name = profile?.name ?? '';
    final effectiveGreeting =
        greeting ?? '${AppStrings.helloPrefix}$name';
    final effectiveTitle =
        title ?? profile?.title ?? AppStrings.defaultProfileTitle;

    return Container(
      width: double.infinity,
      height: height ?? AppDimens.homeHeaderHeight,
      margin: margin,
      padding: const EdgeInsets.all(AppDimens.homeHeaderPadding),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(
          radius ?? AppDimens.homeHeaderRadius,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.headerCardShadow,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
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
          const SizedBox(width: AppDimens.homeAvatarToTextGap),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  effectiveGreeting,
                  style: greetingStyle ?? AppTextStyles.homeGreeting,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  effectiveTitle,
                  style: titleStyle ?? AppTextStyles.homeProfileTitle,
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
