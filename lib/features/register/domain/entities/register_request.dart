/// Immutable value object representing the data submitted on the Register screen.
class RegisterRequest {
  const RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.countryCode,
    required this.phone,
  });

  final String name;
  final String email;
  final String password;
  final String countryCode;
  final String phone;
}
