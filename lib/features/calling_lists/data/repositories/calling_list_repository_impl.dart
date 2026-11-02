import '../../domain/entities/calling_list.dart';
import '../../domain/repositories/calling_list_repository.dart';
import '../datasources/calling_list_remote_data_source.dart';

/// Concrete repository implementation backed by [CallingListRemoteDataSource].
class CallingListRepositoryImpl implements CallingListRepository {
  CallingListRepositoryImpl(this._remoteDataSource);

  final CallingListRemoteDataSource _remoteDataSource;
  List<CallingList> _cachedLists = const [];

  List<CallingList> get cachedLists => _cachedLists;

  @override
  Future<List<CallingList>> getLists() async {
    final models = await _remoteDataSource.fetchCallingLists();
    _cachedLists = models.map((m) => m.toEntity()).toList();
    return _cachedLists;
  }

  @override
  Future<List<CallingList>> refresh() => getLists();
}
