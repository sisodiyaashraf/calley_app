import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:calley_app/core/network/api_client.dart';
import 'package:calley_app/core/network/api_exception.dart';
import 'package:calley_app/features/sign_in/data/datasources/auth_remote_data_source.dart';
import 'package:calley_app/features/sign_in/data/repositories/auth_repository_impl.dart';

class _FakeClient extends http.BaseClient {
  _FakeClient(this._handler);
  final Future<http.Response> Function(http.BaseRequest) _handler;
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final res = await _handler(request);
    return http.StreamedResponse(Stream.value(utf8.encode(res.body)), res.statusCode);
  }
}

void main() {
  test('AuthRepositoryImpl.login success returns AuthUser entity', () async {
    final client = _FakeClient((r) async {
      final body = jsonDecode((r as http.Request).body);
      expect(body['email'], 'john@example.com');
      expect(body['password'], 'secret');
      return http.Response(
        '{"message": "Login successful", "user": {"_id": "u_999", "username": "John Doe", "email": "john@example.com"}}',
        200,
      );
    });
    final repo = AuthRepositoryImpl(AuthRemoteDataSource(ApiClient(client)));
    final user = await repo.login('john@example.com', 'secret');

    expect(user.id, 'u_999');
    expect(user.username, 'John Doe');
    expect(user.email, 'john@example.com');
  });

  test('AuthRepositoryImpl.login 400 throws ApiException', () async {
    final client = _FakeClient((_) async => http.Response('{"message": "Unauthorized"}', 400));
    final repo = AuthRepositoryImpl(AuthRemoteDataSource(ApiClient(client)));
    expect(() => repo.login('a@b.c', 'wrong'), throwsA(isA<ApiException>()));
  });

  test('AuthRepositoryImpl.login timeout throws ApiException', () async {
    final client = _FakeClient((_) => throw TimeoutException('timeout'));
    final repo = AuthRepositoryImpl(AuthRemoteDataSource(ApiClient(client)));
    expect(() => repo.login('a@b.c', 'wrong'), throwsA(isA<ApiException>()));
  });
}
