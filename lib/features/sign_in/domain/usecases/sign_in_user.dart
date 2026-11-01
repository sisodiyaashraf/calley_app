import '../entities/sign_in_request.dart';
import '../repositories/sign_in_repository.dart';

/// Use case that delegates user sign-in to the repository.
class SignInUser {
  const SignInUser(this._repository);

  final SignInRepository _repository;

  Future<bool> call(SignInRequest request) => _repository.signIn(request);
}
