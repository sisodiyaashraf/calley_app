import 'package:flutter/material.dart';
import 'package:outline_pie_chart/outline_pie_chart.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/dashboard_static_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dashboard_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../app_drawer/presentation/widgets/app_drawer.dart';
import '../../../calling_lists/presentation/widgets/calling_lists_sheet.dart';
import '../widgets/call_donut_chart.dart';
import '../widgets/selected_list_card.dart';
import '../widgets/stats_row.dart';

/// Static chart screen rendering constant sample statistics instantly.
class StaticChartPage extends StatelessWidget {
  const StaticChartPage({
    super.key,
    this.onMenuTapped,
    this.onSupportTapped,
    this.onNotificationsTapped,
    this.onStartCallingTapped,
    this.onListTap,
  });

  final VoidCallback? onMenuTapped;
  final VoidCallback? onSupportTapped;
  final VoidCallback? onNotificationsTapped;
  final VoidCallback? onStartCallingTapped;
  final VoidCallback? onListTap;

  void _toast(BuildContext ctx, String msg) => ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
      );

  @override
  Widget build(BuildContext context) {
    const stats = DashboardStaticData.stats;
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      drawerScrimColor: AppColors.drawerScrim,
      drawer: const AppDrawer(),
      appBar: DashboardAppBar(
        onMenuTapped: onMenuTapped,
        onSupportTapped: onSupportTapped ?? () => _toast(context, AppStrings.actionSupport),
        onNotificationsTapped: onNotificationsTapped ?? () => _toast(context, AppStrings.actionNotifications),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          SelectedListCard(
                            listName: stats.listName,
                            totalCalls: stats.totalCalls,
                            avatarLetter: 'S',
                            onTap: onListTap ?? () => CallingListsSheet.show(context),
                          ),
                          const Spacer(),
                          CallDonutChart(stats: stats),
                          const Spacer(),
                          const StatsRow(stats: stats),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: PrimaryButton(
                label: AppStrings.startCallingNow,
                height: 48,
                radius: 10,
                onPressed: onStartCallingTapped ?? () => CallingListsSheet.show(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
