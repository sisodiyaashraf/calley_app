import 'package:flutter/foundation.dart';

/// State management for bottom navigation tab selection and dashboard chart toggle.
class NavProvider extends ChangeNotifier {
  NavProvider({int initialIndex = 2, bool initialShowChart = false})
      : _selectedIndex = initialIndex,
        _showChart = initialShowChart;

  int _selectedIndex;
  int get selectedIndex => _selectedIndex;

  bool _showChart;
  bool get showChart => _showChart;

  void select(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void setShowChart(bool value) {
    if (_showChart != value) {
      _showChart = value;
      notifyListeners();
    }
  }
}
