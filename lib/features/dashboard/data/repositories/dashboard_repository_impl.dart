import '../../domain/entities/call_stats.dart';
import '../../domain/entities/dashboard_info.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_mock_data_source.dart';

/// Concrete repository implementation for Dashboard data and statistics.
class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl(this._dataSource);

  final DashboardMockDataSource _dataSource;

  @override
  Future<DashboardInfo> getDashboardInfo() =>
      _dataSource.fetchDashboardInfo();

  @override
  Future<CallStats> getStats(String listId) =>
      _dataSource.fetchCallStats(listId);
}
