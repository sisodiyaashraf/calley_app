import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/drawer_item.dart';
import '../../domain/usecases/get_drawer_items.dart';
import '../../domain/usecases/logout_user.dart';

/// State management for side navigation drawer menu and user actions.
class DrawerProvider extends ChangeNotifier {
  DrawerProvider({
    required GetDrawerItems getDrawerItems,
    required LogoutUser logoutUser,
  })  : _getDrawerItems = getDrawerItems,
        _logoutUser = logoutUser {
    _initVersion();
  }

  final GetDrawerItems _getDrawerItems;
  final LogoutUser _logoutUser;

  String _appVersion = AppStrings.drawerDefaultVersion;
  String get appVersion => _appVersion;
  String? lastTappedId;

  List<DrawerItem> get mainItems => _getDrawerItems.getMainItems();
  List<DrawerItem> get appInfoItems =>
      _getDrawerItems.getAppInfoItems(version: _appVersion);

  Future<void> _initVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (info.version.isNotEmpty) {
        _appVersion = info.version;
        notifyListeners();
      }
    } catch (_) {
      // Keep default fallback version
    }
  }

  void onItemTapped(String id) {
    lastTappedId = id;
    notifyListeners();
  }

  Future<void> logout() => _logoutUser();
}
