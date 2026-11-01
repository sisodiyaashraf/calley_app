import '../entities/dashboard_info.dart';
import '../repositories/dashboard_repository.dart';

/// Use case that retrieves the dashboard informational card content.
class GetDashboardInfo {
  const GetDashboardInfo(this._repository);

  final DashboardRepository _repository;

  Future<DashboardInfo> call() => _repository.getDashboardInfo();
}
