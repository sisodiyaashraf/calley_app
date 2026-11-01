import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_mock_data_source.dart';

/// Concrete implementation of [HomeRepository] backed by [HomeMockDataSource].
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._dataSource);

  final HomeMockDataSource _dataSource;

  @override
  Future<UserProfile> getProfile() => _dataSource.getProfile();
}
