import '../entities/call_stats.dart';
import '../repositories/dashboard_repository.dart';

/// Use case that fetches call stats for a given list ID.
class GetCallStats {
  const GetCallStats(this._repository);

  final DashboardRepository _repository;

  Future<CallStats> call(String listId, [String? listName]) =>
      _repository.getStats(listId, listName);
}
