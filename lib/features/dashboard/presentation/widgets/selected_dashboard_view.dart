import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../calling_lists/presentation/widgets/calling_lists_sheet.dart';
import '../../domain/entities/call_stats.dart';
import '../providers/dashboard_provider.dart';
import 'call_donut_chart.dart';
import 'selected_list_card.dart';
import 'stats_row.dart';

/// Dashboard view presented when a calling list is actively selected.
class SelectedDashboardView extends StatelessWidget {
  const SelectedDashboardView({
    super.key,
    required this.stats,
    required this.onStartCalling,
  });

  final CallStats stats;
  final VoidCallback onStartCalling;

  @override
  Widget build(BuildContext context) {
    final dash = context.read<DashboardProvider>();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SelectedListCard(
                  listName: stats.listName,
                  totalCalls: stats.totalCalls,
                  onTap: () => CallingListsSheet.show(
                    context,
                    onListSelected: (l) => dash.loadStats(l.id, l.name),
                  ),
                ),
                const SizedBox(height: 14),
                CallDonutChart(stats: stats),
                const SizedBox(height: 14),
                StatsRow(stats: stats),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          child: PrimaryButton(
            label: AppStrings.startCallingNow,
            height: 46,
            radius: 8,
            onPressed: onStartCalling,
          ),
        ),
      ],
    );
  }
}
