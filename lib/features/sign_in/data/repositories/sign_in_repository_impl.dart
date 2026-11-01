import '../../domain/entities/sign_in_request.dart';
import '../../domain/repositories/sign_in_repository.dart';
import '../datasources/sign_in_mock_data_source.dart';

/// Concrete repository implementation backed by [SignInMockDataSource].
class SignInRepositoryImpl implements SignInRepository {
  const SignInRepositoryImpl(this._dataSource);

  final SignInMockDataSource _dataSource;

  @override
  Future<bool> signIn(SignInRequest request) => _dataSource.signIn(request);

  @override
  Future<void> logout() => _dataSource.logout();
}
