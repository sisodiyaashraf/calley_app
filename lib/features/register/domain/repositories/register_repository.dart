import '../entities/register_request.dart';

/// Contract that the data layer must fulfil.
/// Returns true on success; throws on network/server error.
abstract class RegisterRepository {
  Future<bool> register(RegisterRequest request);
}
