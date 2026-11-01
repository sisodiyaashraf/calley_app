import 'package:flutter/foundation.dart';

/// State management for bottom navigation tab selection.
class NavProvider extends ChangeNotifier {
  NavProvider({int initialIndex = 2}) : _selectedIndex = initialIndex;

  int _selectedIndex;
  int get selectedIndex => _selectedIndex;

  void select(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }
}
