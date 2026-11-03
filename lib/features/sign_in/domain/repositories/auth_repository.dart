import '../entities/auth_user.dart';

/// Contract that the data layer must fulfill for user authentication.
abstract class AuthRepository {
  Future<AuthUser> login(String email, String password);
}
