import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Single colored statistics card with accent bar, count, and subtitle.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.label,
    required this.count,
    required this.backgroundColor,
    required this.barColor,
  });

  final String label;
  final int count;
  final Color backgroundColor;
  final Color barColor;

  @override
  Widget build(BuildContext context) {
    final countFormatted = count.toString().padLeft(2, '0');

    return Container(
      height: AppDimens.statTileHeight,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: AppDimens.statTilePadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimens.statTileRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: AppDimens.statTileBarWidth,
            height: AppDimens.statTileBarHeight,
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: AppTextStyles.statTileLabel,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  countFormatted,
                  style: AppTextStyles.statTileCount,
                ),
                Text(
                  AppStrings.callsLower,
                  style: AppTextStyles.statTileSub,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
