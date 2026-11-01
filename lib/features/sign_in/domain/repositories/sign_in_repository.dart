import '../entities/sign_in_request.dart';

/// Contract that the data layer must fulfill for user sign-in.
abstract class SignInRepository {
  Future<bool> signIn(SignInRequest request);
}
