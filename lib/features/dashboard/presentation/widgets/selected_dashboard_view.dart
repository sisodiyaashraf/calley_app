import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../calling_lists/presentation/widgets/calling_lists_sheet.dart';
import '../../domain/entities/call_stats.dart';
import 'call_donut_chart.dart';
import 'selected_list_card.dart';
import 'stats_row.dart';

/// Dashboard view presented when a calling list is actively selected.
class SelectedDashboardView extends StatelessWidget {
  const SelectedDashboardView({
    super.key,
    required this.stats,
    required this.onStartCalling,
    this.onListTap,
    this.avatarLetter,
    this.isSampleData = false,
  });

  final CallStats stats;
  final VoidCallback onStartCalling;
  final VoidCallback? onListTap;
  final String? avatarLetter;
  final bool isSampleData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        SelectedListCard(
                          listName: stats.listName,
                          totalCalls: stats.totalCalls,
                          avatarLetter: avatarLetter,
                          onTap: onListTap ?? () => CallingListsSheet.show(context),
                        ),
                        const Spacer(),
                        CallDonutChart(stats: stats),
                        const Spacer(),
                        StatsRow(stats: stats),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: PrimaryButton(
            label: AppStrings.startCallingNow,
            height: 48,
            radius: 10,
            onPressed: onStartCalling,
          ),
        ),
      ],
    );
  }
}
