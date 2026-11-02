import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/features/dashboard/domain/entities/call_stats.dart';
import 'package:calley_app/features/dashboard/domain/entities/dashboard_info.dart';
import 'package:calley_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_call_stats.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_dashboard_info.dart';
import 'package:calley_app/features/dashboard/presentation/providers/dashboard_provider.dart';

class _FakeDashboardRepo implements DashboardRepository {
  @override
  Future<DashboardInfo> getDashboardInfo() async => const DashboardInfo(
        cardTitle: AppStrings.loadNumberToCall,
        message: AppStrings.loadNumberMessage,
        link: AppStrings.loadNumberUrl,
      );

  @override
  Future<CallStats> getStats(String listId, [String? listName]) async => const CallStats(
        listName: AppStrings.testList,
        totalCalls: 50,
        pending: 28,
        done: 22,
        scheduled: 9,
      );
}

void main() {
  test('DashboardProvider loads dashboard info successfully', () async {
    final repo = _FakeDashboardRepo();
    final provider = DashboardProvider(
      getDashboardInfo: GetDashboardInfo(repo),
      getCallStats: GetCallStats(repo),
    );

    expect(provider.isLoading, isTrue);
    await provider.load();
    expect(provider.isLoading, isFalse);
    expect(provider.info, isNotNull);
    expect(provider.info!.cardTitle, AppStrings.loadNumberToCall);

    expect(provider.hasSelectedList, isFalse);
    await provider.loadStats('1');
    expect(provider.hasSelectedList, isTrue);
    expect(provider.stats?.listName, AppStrings.testList);
    expect(provider.stats?.totalCalls, 50);
  });
}
