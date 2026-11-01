import '../../domain/entities/sign_in_request.dart';

/// Simulated data source for sign-in with network delay.
class SignInMockDataSource {
  const SignInMockDataSource();

  Future<bool> signIn(SignInRequest request) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return true;
  }
}
