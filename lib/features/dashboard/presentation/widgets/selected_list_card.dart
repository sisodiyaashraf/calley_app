import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Card displaying the selected list name, total calls count, and letter avatar.
class SelectedListCard extends StatelessWidget {
  const SelectedListCard({
    super.key,
    required this.listName,
    required this.totalCalls,
    this.onTap,
  });

  final String listName;
  final int totalCalls;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final firstLetter = listName.isNotEmpty ? listName[0].toUpperCase() : '';

    return Container(
      height: AppDimens.selectedListHeight,
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.selectedListMargin),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.selectedListRadius),
        border: Border.all(color: AppColors.cardBorder, width: AppDimens.cardBorderWidth),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimens.selectedListRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(listName, style: AppTextStyles.selectedListName, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text('$totalCalls', style: AppTextStyles.selectedListCount),
                          const SizedBox(width: 6),
                          Text(AppStrings.callsCaps, style: AppTextStyles.selectedListCallsLabel),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: AppDimens.selectedListAvatarSize,
                  height: AppDimens.selectedListAvatarSize,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppDimens.selectedListRadius),
                  ),
                  alignment: Alignment.center,
                  child: Text(firstLetter, style: AppTextStyles.selectedListAvatarLetter),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
