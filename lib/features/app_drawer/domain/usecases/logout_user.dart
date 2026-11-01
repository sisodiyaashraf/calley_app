import '../../../sign_in/domain/repositories/sign_in_repository.dart';

/// Logs out the user session via the sign-in repository.
class LogoutUser {
  const LogoutUser(this._repository);

  final SignInRepository _repository;

  Future<void> call() => _repository.logout();
}
