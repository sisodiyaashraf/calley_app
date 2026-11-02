import 'package:flutter/foundation.dart';

/// In-memory user session holding authentication tokens and user credentials.
class Session extends ChangeNotifier {
  Session({
    this.userId = '68626f9497757cb741f449b0',
    String? email,
    String? name,
  })  : _email = email ?? 'dhrubo@yopmail.com',
        _name = name ?? '';

  static final Session instance = Session();

  String userId;
  String _email;
  String _name;

  String get email => _email;
  String get name => _name;

  bool get isEmpty => _name.trim().isEmpty;
  String get displayName => _name.trim().isEmpty ? 'Guest' : _name.trim();

  void update({String? newUserId, String? newEmail, String? newName}) {
    if (newUserId != null) userId = newUserId;
    if (newEmail != null) _email = newEmail;
    if (newName != null) _name = newName;
    notifyListeners();
  }

  void clear() {
    _name = '';
    _email = '';
    notifyListeners();
  }
}
