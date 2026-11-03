import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/network/api_client.dart';
import 'package:calley_app/core/session/session.dart';
import 'package:calley_app/features/calling_lists/data/datasources/calling_list_remote_data_source.dart';
import 'package:calley_app/features/calling_lists/data/models/calling_list_model.dart';
import 'package:calley_app/features/calling_lists/data/repositories/calling_list_repository_impl.dart';
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
    "_id": "68626fb697757cb741f449b9",
    "name": "Test List",
    "agents": [],
    "clientId": "68626f9497757cb741f449b0",
  };

  test('CallingListModel fromJson parses sample response correctly', () {
    final model = CallingListModel.fromJson(sampleJson);
    expect(model.id, "68626fb697757cb741f449b9");
    expect(model.name, "Test List");
    expect(model.agents, isEmpty);
    expect(model.clientId, "68626f9497757cb741f449b0");

    final entity = model.toEntity();
    expect(entity.id, model.id);
    expect(entity.name, model.name);
    expect(entity.clientId, model.clientId);
  });

  test('CallingListRepositoryImpl maps remote data source to domain entity', () async {
    final client = _MockHttpClient((request) async {
      expect(request.url.queryParameters['userId'], '68626f9497757cb741f449b0');
      expect(jsonDecode(request.body)['email'], 'dhrubo@yopmail.com');
      return http.Response(jsonEncode([sampleJson]), 200, headers: {'content-type': 'application/json'});
    });

    final apiClient = ApiClient(client);
    final session = Session(userId: '68626f9497757cb741f449b0', email: 'dhrubo@yopmail.com');
    final dataSource = CallingListRemoteDataSource(apiClient: apiClient, session: session);
    final repo = CallingListRepositoryImpl(dataSource);

    final lists = await repo.getLists();
    expect(lists.length, 1);
    expect(lists.first.id, "68626fb697757cb741f449b9");
    expect(lists.first.name, "Test List");
    expect(lists.first.clientId, "68626f9497757cb741f449b0");
  });
}
