import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/call_stats.dart';
import '../../domain/entities/dashboard_info.dart';

/// Mock data source providing realistic dashboard details and call statistics.
class DashboardMockDataSource {
  const DashboardMockDataSource();

  Future<DashboardInfo> fetchDashboardInfo() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return const DashboardInfo(
      cardTitle: AppStrings.loadNumberToCall,
      message: AppStrings.loadNumberMessage,
      link: AppStrings.loadNumberUrl,
    );
  }

  Future<CallStats> fetchCallStats(String listId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return const CallStats(
      listName: AppStrings.testList,
      totalCalls: 50,
      pending: 28,
      done: 22,
      scheduled: 9,
    );
  }
}
