import '../../features/dashboard/domain/entities/call_stats.dart';
import 'app_strings.dart';

/// Predefined static data for DashboardChartPage.
class DashboardStaticData {
  DashboardStaticData._();

  static const String listName = AppStrings.testList;
  static const int totalCalls = 50;
  static const int pending = 28;
  static const int done = 22;
  static const int scheduled = 9;

  static const CallStats stats = CallStats(
    listName: listName,
    totalCalls: totalCalls,
    pending: pending,
    done: done,
    scheduled: scheduled,
  );
}
