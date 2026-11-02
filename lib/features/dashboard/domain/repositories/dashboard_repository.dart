import '../entities/call_stats.dart';
import '../entities/dashboard_info.dart';

/// Contract for fetching dashboard details and call statistics.
abstract class DashboardRepository {
  Future<DashboardInfo> getDashboardInfo();
  Future<CallStats> getStats(String listId, [String? listName]);
}
