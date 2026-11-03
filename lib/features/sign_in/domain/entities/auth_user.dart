/// Authenticated user entity returned upon successful login.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.username,
    required this.email,
  });

  final String id;
  final String username;
  final String email;
}
