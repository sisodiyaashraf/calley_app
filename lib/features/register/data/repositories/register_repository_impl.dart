import '../../domain/entities/register_request.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_mock_data_source.dart';

/// Concrete [RegisterRepository] backed by [RegisterMockDataSource].
class RegisterRepositoryImpl implements RegisterRepository {
  const RegisterRepositoryImpl(this._dataSource);

  final RegisterMockDataSource _dataSource;

  @override
  Future<bool> register(RegisterRequest request) =>
      _dataSource.register(request);
}
