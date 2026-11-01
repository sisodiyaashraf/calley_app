import '../entities/register_request.dart';
import '../repositories/register_repository.dart';

/// Use-case: delegates a register request to the repository.
class RegisterUser {
  const RegisterUser(this._repository);

  final RegisterRepository _repository;

  Future<bool> call(RegisterRequest request) => _repository.register(request);
}
