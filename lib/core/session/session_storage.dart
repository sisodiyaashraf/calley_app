import 'package:shared_preferences/shared_preferences.dart';
import '../constants/session_keys.dart';

/// Data transfer object holding restored session state.
class SessionData {
  const SessionData({
    required this.name,
    required this.email,
    required this.isLoggedIn,
  });

  final String name;
  final String email;
  final bool isLoggedIn;
}

/// Asynchronous persistent storage wrapper for user session credentials.
class SessionStorage {
  SessionStorage._();

  static Future<void> save(String name, String email) async {
    try {
      final prefs = await SharedPreferences.getInstance()
          .timeout(const Duration(milliseconds: 500));
      await prefs.setString(SessionKeys.name, name);
      await prefs.setString(SessionKeys.email, email);
      await prefs.setBool(SessionKeys.isLoggedIn, true);
    } catch (_) {}
  }

  static Future<SessionData> load() async {
    try {
      final prefs = await SharedPreferences.getInstance()
          .timeout(const Duration(milliseconds: 500));
      final name = prefs.getString(SessionKeys.name) ?? '';
      final email = prefs.getString(SessionKeys.email) ?? '';
      final loggedIn = prefs.getBool(SessionKeys.isLoggedIn) ?? false;
      return SessionData(name: name, email: email, isLoggedIn: loggedIn);
    } catch (_) {
      return const SessionData(name: '', email: '', isLoggedIn: false);
    }
  }

  static Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance()
          .timeout(const Duration(milliseconds: 500));
      await prefs.remove(SessionKeys.name);
      await prefs.remove(SessionKeys.email);
      await prefs.remove(SessionKeys.isLoggedIn);
    } catch (_) {}
  }
}
