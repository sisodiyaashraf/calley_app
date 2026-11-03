/// Storage keys for persisting user session credentials.
class SessionKeys {
  SessionKeys._();

  static const String name = 'session_name';
  static const String email = 'session_email';
  static const String isLoggedIn = 'session_is_logged_in';
  static const String userId = 'session_user_id';
}
