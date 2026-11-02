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
    this.isSampleData = false,
  });

  final CallStats stats;
  final VoidCallback onStartCalling;
  final VoidCallback? onListTap;
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
                        SelectedListCard(
                          listName: stats.listName,
                          totalCalls: stats.totalCalls,
                          onTap: onListTap ?? () => CallingListsSheet.show(context),
                        ),
                        if (isSampleData)
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              'Showing sample data',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        const Spacer(),
                        CallDonutChart(stats: stats),
                        const Spacer(),
                        StatsRow(stats: stats),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
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
