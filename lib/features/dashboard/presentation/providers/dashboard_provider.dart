import 'package:flutter/foundation.dart';
import '../../domain/entities/call_stats.dart';
import '../../domain/entities/dashboard_info.dart';
import '../../domain/usecases/get_call_stats.dart';
import '../../domain/usecases/get_dashboard_info.dart';

/// State management for the Dashboard feature and calling list statistics.
class DashboardProvider extends ChangeNotifier {
  DashboardProvider({
    required GetDashboardInfo getDashboardInfo,
    GetCallStats? getCallStats,
  })  : _getDashboardInfo = getDashboardInfo,
        _getCallStats = getCallStats {
    load();
  }

  final GetDashboardInfo _getDashboardInfo;
  final GetCallStats? _getCallStats;

  DashboardInfo? info;
  CallStats? stats;
  bool isLoading = true;
  bool isLoadingStats = false;

  bool get hasSelectedList => stats != null;

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    try {
      info = await _getDashboardInfo();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadStats(String listId) async {
    isLoadingStats = true;
    notifyListeners();
    try {
      if (_getCallStats != null) {
        stats = await _getCallStats(listId);
      }
    } finally {
      isLoadingStats = false;
      notifyListeners();
    }
  }

  void clearStats() {
    stats = null;
    notifyListeners();
  }
}
