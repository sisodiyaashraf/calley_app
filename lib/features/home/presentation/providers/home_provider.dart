import 'package:flutter/foundation.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_user_profile.dart';

/// State management for the Home dashboard, user profile, and first-time flag.
class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required GetUserProfile getUserProfile,
    bool isFirstTimeUser = false,
  })  : _getUserProfile = getUserProfile,
        _isFirstTimeUser = isFirstTimeUser {
    load();
  }

  final GetUserProfile _getUserProfile;

  UserProfile? profile;
  bool isLoading = true;

  /// Decides which screen the Dashboard tab shows:
  /// true -> Screen 5 (HomePage), false -> DashboardPage.
  bool _isFirstTimeUser = false;
  bool get isFirstTimeUser => _isFirstTimeUser;

  set isFirstTimeUser(bool value) {
    if (_isFirstTimeUser != value) {
      _isFirstTimeUser = value;
      notifyListeners();
    }
  }

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    try {
      profile = await _getUserProfile();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
