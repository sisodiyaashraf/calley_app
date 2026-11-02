import 'package:flutter/foundation.dart';
import '../../../../core/network/api_exception.dart';
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
  String? error;
  bool isRefreshing = false;
  bool isLoading = false;

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      lists = await _getCallingLists();
      if (lists.length == 1) {
        selected = lists.first;
      }
    } on AppException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retry() => load();

  Future<void> refresh() async {
    if (isRefreshing) return;
    isRefreshing = true;
    error = null;
    notifyListeners();
    try {
      lists = await _refreshCallingLists();
      if (selected != null) {
        final matches = lists.where((l) => l.id == selected!.id);
        if (matches.isNotEmpty) {
          selected = matches.first;
        }
      } else if (lists.length == 1) {
        selected = lists.first;
      }
    } on AppException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
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
