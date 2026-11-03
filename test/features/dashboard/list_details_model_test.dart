import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/network/api_client.dart';
import 'package:calley_app/core/session/session.dart';
import 'package:calley_app/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:calley_app/features/dashboard/data/models/list_details_model.dart';
import 'package:calley_app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:http/http.dart' as http;

class _MockHttpClient extends http.BaseClient {
  _MockHttpClient(this._handler);
  final Future<http.Response> Function(http.Request request) _handler;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _handler(request as http.Request);
    return http.StreamedResponse(
      Stream.value(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
    );
  }
}

void main() {
  const sampleJson = {
    "pending": 27,
    "called": 23,
    "rescheduled": 11,
    "calls": [
      {
        "FirstName": "Danielle",
        "LastName": "Johnson",
        "Title": "Mrs.",
        "Phone": 1000000000,
      }
    ],
  };

  test('ListDetailsModel fromJson parses sample response and extracts calls length', () {
    final model = ListDetailsModel.fromJson(sampleJson);
    expect(model.pending, 27);
    expect(model.called, 23);
    expect(model.rescheduled, 11);
    expect(model.callsCount, 1);
  });

  test('DashboardRepositoryImpl maps remote response to CallStats entity', () async {
    final client = _MockHttpClient((request) async {
      expect(request.url.path, '/api/list/68626fb697757cb741f449b9');
      expect(jsonDecode(request.body)['email'], 'dhrubo@yopmail.com');
      return http.Response(jsonEncode(sampleJson), 200, headers: {'content-type': 'application/json'});
    });

    final apiClient = ApiClient(client);
    final session = Session(userId: '68626f9497757cb741f449b0', email: 'dhrubo@yopmail.com');
    final dataSource = DashboardRemoteDataSource(apiClient: apiClient, session: session);
    final repo = DashboardRepositoryImpl(dataSource);

    final stats = await repo.getStats('68626fb697757cb741f449b9', 'Test List');
    expect(stats.listName, 'Test List');
    expect(stats.totalCalls, 1);
    expect(stats.pending, 27);
    expect(stats.done, 23);
    expect(stats.scheduled, 11);
  });
}
