import '../entities/calling_list.dart';

/// Contract for calling list retrieval and synchronization.
abstract class CallingListRepository {
  Future<List<CallingList>> getLists();
  Future<List<CallingList>> refresh();
}
