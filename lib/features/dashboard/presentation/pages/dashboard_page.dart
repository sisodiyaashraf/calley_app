import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/navigation/nav_provider.dart';
import '../../../calling_lists/presentation/providers/calling_list_provider.dart';
import 'dashboard_chart_page.dart';
import 'dashboard_load_page.dart';

/// Screen 6 – Dashboard page rendering [DashboardChartPage] or [DashboardLoadPage].
class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    this.onMenuTapped,
    this.onSupportTapped,
    this.onNotificationsTapped,
    this.onLinkTapped,
    this.onWhatsAppTapped,
    this.onStartCallingTapped,
    this.showChart,
  });

  final VoidCallback? onMenuTapped, onSupportTapped, onNotificationsTapped;
  final VoidCallback? onLinkTapped, onWhatsAppTapped, onStartCallingTapped;
  final bool? showChart;

  bool _resolveShowChart(BuildContext context) {
    if (showChart != null) return showChart!;
    try {
      final nav = Provider.of<NavProvider>(context);
      return nav.showChart;
    } catch (_) {}
    try {
      final listP = Provider.of<CallingListProvider>(context);
      if (listP.selected != null) return true;
    } catch (_) {}
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return _resolveShowChart(context)
        ? DashboardChartPage(
            onMenuTapped: onMenuTapped,
            onSupportTapped: onSupportTapped,
            onNotificationsTapped: onNotificationsTapped,
            onStartCallingTapped: onStartCallingTapped,
          )
        : DashboardLoadPage(
            onMenuTapped: onMenuTapped,
            onSupportTapped: onSupportTapped,
            onNotificationsTapped: onNotificationsTapped,
            onLinkTapped: onLinkTapped,
            onWhatsAppTapped: onWhatsAppTapped,
            onStartCallingTapped: onStartCallingTapped,
          );
  }
}
