import '../entities/calling_list.dart';
import '../repositories/calling_list_repository.dart';

/// Use case that fetches available calling lists.
class GetCallingLists {
  const GetCallingLists(this._repository);

  final CallingListRepository _repository;

  Future<List<CallingList>> call() => _repository.getLists();
}
