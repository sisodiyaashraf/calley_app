import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/call_stats.dart';
import '../../domain/entities/dashboard_info.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

/// Concrete repository implementation backed by [DashboardRemoteDataSource].
class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl(this._remoteDataSource, {String? defaultListName})
      : _defaultListName = defaultListName ?? AppStrings.testList;

  final DashboardRemoteDataSource _remoteDataSource;
  final String _defaultListName;

  @override
  Future<DashboardInfo> getDashboardInfo() async {
    return const DashboardInfo(
      cardTitle: AppStrings.loadNumberToCall,
      message: AppStrings.loadNumberMessage,
      link: AppStrings.loadNumberUrl,
    );
  }

  @override
  Future<CallStats> getStats(String listId, [String? listName]) async {
    final details = await _remoteDataSource.fetchListDetails(listId);
    return CallStats(
      listName: listName ?? _defaultListName,
      totalCalls: details.callsCount,
      pending: details.pending,
      done: details.called,
      scheduled: details.rescheduled,
    );
  }
}
