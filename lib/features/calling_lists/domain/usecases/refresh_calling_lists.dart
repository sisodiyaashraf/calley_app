import '../entities/calling_list.dart';
import '../repositories/calling_list_repository.dart';

/// Use case that refreshes and syncs calling lists.
class RefreshCallingLists {
  const RefreshCallingLists(this._repository);

  final CallingListRepository _repository;

  Future<List<CallingList>> call() => _repository.refresh();
}
