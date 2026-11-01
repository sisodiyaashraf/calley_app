import '../../domain/entities/calling_list.dart';
import '../../domain/repositories/calling_list_repository.dart';
import '../datasources/calling_list_mock_data_source.dart';

/// Concrete repository implementation for Calling Lists.
class CallingListRepositoryImpl implements CallingListRepository {
  const CallingListRepositoryImpl(this._dataSource);

  final CallingListMockDataSource _dataSource;

  @override
  Future<List<CallingList>> getLists() => _dataSource.fetchCallingLists();

  @override
  Future<List<CallingList>> refresh() => _dataSource.refreshCallingLists();
}
