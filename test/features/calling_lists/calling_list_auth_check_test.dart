import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:calley_app/core/network/api_client.dart';
import 'package:calley_app/core/network/api_exception.dart';
import 'package:calley_app/core/session/session.dart';
import 'package:calley_app/features/calling_lists/data/datasources/calling_list_remote_data_source.dart';
import 'package:calley_app/features/dashboard/data/datasources/dashboard_remote_data_source.dart';

class _ExplodingClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    throw StateError('API should not be called when session has no userId');
  }
}

void main() {
  test('CallingListRemoteDataSource throws Please sign in again and does not call API when userId is empty', () async {
    final session = Session(userId: '', email: '');
    final ds = CallingListRemoteDataSource(apiClient: ApiClient(_ExplodingClient()), session: session);
    expect(() => ds.fetchCallingLists(), throwsA(predicate((e) => e is AppException && e.message == 'Please sign in again')));
  });

  test('DashboardRemoteDataSource throws Please sign in again and does not call API when userId is empty', () async {
    final session = Session(userId: '', email: '');
    final ds = DashboardRemoteDataSource(apiClient: ApiClient(_ExplodingClient()), session: session);
    expect(() => ds.fetchListDetails('list_1'), throwsA(predicate((e) => e is AppException && e.message == 'Please sign in again')));
  });
}
