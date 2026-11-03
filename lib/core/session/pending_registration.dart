/// In-memory holder for unverified user registration credentials.
class PendingRegistration {
  PendingRegistration._();

  static String? _email;
  static String? _password;

  static String? get email => _email;
  static String? get password => _password;

  static void set(String email, String password) {
    _email = email;
    _password = password;
  }

  static void clear() {
    _email = null;
    _password = null;
  }

  static bool get hasData =>
      _email != null && _email!.isNotEmpty && _password != null && _password!.isNotEmpty;
}
