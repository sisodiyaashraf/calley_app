import 'package:flutter/foundation.dart';
import '../../domain/entities/calling_list.dart';
import '../../domain/usecases/get_calling_lists.dart';
import '../../domain/usecases/refresh_calling_lists.dart';

/// State management for calling lists selection and refresh status.
class CallingListProvider extends ChangeNotifier {
  CallingListProvider({
    required GetCallingLists getCallingLists,
    required RefreshCallingLists refreshCallingLists,
  })  : _getCallingLists = getCallingLists,
        _refreshCallingLists = refreshCallingLists {
    load();
  }

  final GetCallingLists _getCallingLists;
  final RefreshCallingLists _refreshCallingLists;

  List<CallingList> lists = const [];
  CallingList? selected;
  bool isRefreshing = false;
  bool isLoading = false;

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    try {
      lists = await _getCallingLists();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    if (isRefreshing) return;
    isRefreshing = true;
    notifyListeners();
    try {
      lists = await _refreshCallingLists();
    } finally {
      isRefreshing = false;
      notifyListeners();
    }
  }

  void select(CallingList? list) {
    selected = list;
    notifyListeners();
  }
}
