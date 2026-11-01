import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/app_colors.dart';

/// Rounded video thumbnail preserving original aspect ratio with tap handler.
class VideoThumbnail extends StatelessWidget {
  const VideoThumbnail({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.homeVideoBorderRadius),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.cardBorder,
              width: AppDimens.homeVideoBorderWidth,
            ),
            borderRadius: BorderRadius.circular(AppDimens.homeVideoBorderRadius),
          ),
          child: AspectRatio(
            aspectRatio: 1835 / 1017,
            child: Image.asset(
              AppAssets.mediaplayer,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
