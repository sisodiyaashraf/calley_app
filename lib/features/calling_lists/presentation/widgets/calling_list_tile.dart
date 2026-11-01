import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/arrow_box_button.dart';
import '../../domain/entities/calling_list.dart';

/// Single calling list selection tile with name and trailing arrow box button.
class CallingListTile extends StatelessWidget {
  const CallingListTile({
    super.key,
    required this.list,
    required this.onTap,
  });

  final CallingList list;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.callingListTileRadius),
      child: Container(
        height: AppDimens.callingListTileHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.callingListTilePadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.bottomNavBackground,
          borderRadius: BorderRadius.circular(AppDimens.callingListTileRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                list.name,
                style: AppTextStyles.selectCallingListTitle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ArrowBoxButton(onTap: onTap),
          ],
        ),
      ),
    );
  }
}
