import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

/// Use case to authenticate user and retrieve real userId and credentials.
class LoginUser {
  const LoginUser(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call(String email, String password) =>
      _repository.login(email, password);
}
