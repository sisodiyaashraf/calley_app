import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/dashboard_static_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dashboard_app_bar.dart';
import '../../../calling_lists/presentation/widgets/calling_lists_sheet.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/selected_dashboard_view.dart';

/// Screen 4 – Dashboard Chart Page displaying API statistics with static fallback.
class DashboardChartPage extends StatelessWidget {
  const DashboardChartPage({
    super.key,
    this.onMenuTapped,
    this.onSupportTapped,
    this.onNotificationsTapped,
    this.onStartCallingTapped,
    this.onListTap,
  });

  final VoidCallback? onMenuTapped, onSupportTapped, onNotificationsTapped;
  final VoidCallback? onStartCallingTapped, onListTap;

  void _toast(BuildContext ctx, String msg) => ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
      );

  @override
  Widget build(BuildContext context) {
    DashboardProvider? dash;
    try {
      dash = context.watch<DashboardProvider>();
    } catch (_) {}

    final isLoading = dash != null && dash.isLoadingStats;
    final hasRealStats = dash != null && dash.stats != null;
    final stats = hasRealStats ? dash.stats! : DashboardStaticData.stats;
    final isSample = !hasRealStats;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: DashboardAppBar(
        onMenuTapped: onMenuTapped ?? () => Scaffold.of(context).openDrawer(),
        onSupportTapped: onSupportTapped ?? () => _toast(context, AppStrings.actionSupport),
        onNotificationsTapped: onNotificationsTapped ?? () => _toast(context, AppStrings.actionNotifications),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SelectedDashboardView(
                stats: stats,
                isSampleData: isSample,
                onStartCalling: onStartCallingTapped ?? () => CallingListsSheet.show(context),
                onListTap: onListTap ?? () => CallingListsSheet.show(context),
              ),
      ),
    );
  }
}
