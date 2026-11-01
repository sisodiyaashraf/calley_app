import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/call_stats.dart';
import 'stat_tile.dart';

/// Row of 3 stat cards: Pending, Done, and Schedule.
class StatsRow extends StatelessWidget {
  const StatsRow({super.key, required this.stats});

  final CallStats stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.selectedListMargin,
      ),
      child: Row(
        children: [
          Expanded(
            child: StatTile(
              label: AppStrings.pendingLabel,
              count: stats.pending,
              backgroundColor: AppColors.statPendingBg,
              barColor: AppColors.statPendingBar,
            ),
          ),
          const SizedBox(width: AppDimens.statsRowGap),
          Expanded(
            child: StatTile(
              label: AppStrings.doneLabel,
              count: stats.done,
              backgroundColor: AppColors.statDoneBg,
              barColor: AppColors.statDoneBar,
            ),
          ),
          const SizedBox(width: AppDimens.statsRowGap),
          Expanded(
            child: StatTile(
              label: AppStrings.scheduleLabel,
              count: stats.scheduled,
              backgroundColor: AppColors.statScheduleBg,
              barColor: AppColors.statScheduleBar,
            ),
          ),
        ],
      ),
    );
  }
}
