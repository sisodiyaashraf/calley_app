/// Immutable value object representing a sign-in request.
class SignInRequest {
  const SignInRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
