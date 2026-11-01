import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_card.dart';
import '../../domain/entities/calling_list.dart';
import '../providers/calling_list_provider.dart';
import 'calling_list_tile.dart';
import 'refresh_button.dart';

/// Modal bottom sheet displaying available calling lists and refresh action.
class CallingListsSheet extends StatelessWidget {
  const CallingListsSheet({super.key, this.onListSelected});

  final ValueChanged<CallingList>? onListSelected;

  static Future<void> show(
    BuildContext context, {
    ValueChanged<CallingList>? onListSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) => CallingListsSheet(onListSelected: onListSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CallingListProvider>();
    final bottomPad = MediaQuery.of(context).padding.bottom + 24.0;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPad),
      child: SectionCard(
        title: AppStrings.callingListsBand,
        titleStyle: AppTextStyles.callingListsBand,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: AppDimens.callingListTileHeight,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.callingListTilePadding,
              ),
              decoration: BoxDecoration(
                color: AppColors.bottomNavBackground,
                borderRadius: BorderRadius.circular(
                  AppDimens.callingListTileRadius,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.selectCallingList,
                      style: AppTextStyles.selectCallingListTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  RefreshButton(
                    isRefreshing: provider.isRefreshing,
                    onPressed: provider.refresh,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.callingListTileGap),
            if (provider.lists.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    AppStrings.noCallingLists,
                    style: AppTextStyles.callingListEmptyText,
                  ),
                ),
              )
            else
              ...provider.lists.map(
                (list) => CallingListTile(
                  list: list,
                  onTap: () {
                    provider.select(list);
                    Navigator.of(context).pop();
                    onListSelected?.call(list);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
