import 'package:flutter/foundation.dart';
import '../../../../core/network/api_exception.dart';
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
  String? error;
  String? _lastListId;
  String? _lastListName;
  bool isLoading = true;
  bool isLoadingStats = false;

  bool get hasSelectedList => stats != null;

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      info = await _getDashboardInfo();
    } on AppException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadStats(String listId, [String? listName]) async {
    _lastListId = listId;
    if (listName != null) _lastListName = listName;
    isLoadingStats = true;
    error = null;
    notifyListeners();
    try {
      if (_getCallStats != null) {
        stats = await _getCallStats(listId, _lastListName);
      }
    } on AppException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoadingStats = false;
      notifyListeners();
    }
  }

  Future<void> retry() async {
    if (_lastListId != null) {
      await loadStats(_lastListId!, _lastListName);
    } else {
      await load();
    }
  }

  void clearStats() {
    stats = null;
    error = null;
    notifyListeners();
  }
}
