import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:calley_app/core/network/api_client.dart';
import 'package:calley_app/core/network/api_exception.dart';
import 'package:calley_app/features/otp/data/datasources/otp_remote_data_source.dart';
import 'package:calley_app/features/otp/data/repositories/otp_repository_impl.dart';
import 'package:calley_app/features/otp/domain/entities/otp_verification.dart';

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
  const v = OtpVerification(email: 'user@a.com', code: '123456');

  test('OtpRepositoryImpl.verify success', () async {
    final client = _FakeClient((r) async {
      final body = jsonDecode((r as http.Request).body);
      expect(body['email'], 'user@a.com'); expect(body['otp'], '123456');
      return http.Response('{"message": "OTP Verfied"}', 200);
    });
    final repo = OtpRepositoryImpl(OtpRemoteDataSource(ApiClient(client)));
    expect(await repo.verify(v), isTrue);
  });

  test('OtpRepositoryImpl.verify 400 throws ApiException', () async {
    final client = _FakeClient((_) async => http.Response('{"message": "Invalid OTP"}', 400));
    final repo = OtpRepositoryImpl(OtpRemoteDataSource(ApiClient(client)));
    expect(() => repo.verify(v), throwsA(isA<ApiException>()));
  });

  test('OtpRepositoryImpl.verify timeout throws ApiException', () async {
    final client = _FakeClient((_) => throw TimeoutException('timeout'));
    final repo = OtpRepositoryImpl(OtpRemoteDataSource(ApiClient(client)));
    expect(() => repo.verify(v), throwsA(isA<ApiException>()));
  });

  test('OtpRepositoryImpl.resend success', () async {
    final client = _FakeClient((r) async {
      final body = jsonDecode((r as http.Request).body);
      expect(body['email'], 'user@a.com');
      return http.Response('{"message": "OTP sent"}', 200);
    });
    final repo = OtpRepositoryImpl(OtpRemoteDataSource(ApiClient(client)));
    expect(await repo.resend('user@a.com'), isTrue);
  });

  test('OtpRepositoryImpl.resend 400 and timeout throw ApiException', () async {
    final c400 = _FakeClient((_) async => http.Response('{"message": "Fail"}', 400));
    final cTimeout = _FakeClient((_) => throw TimeoutException('timeout'));
    expect(() => OtpRepositoryImpl(OtpRemoteDataSource(ApiClient(c400))).resend('a@b.c'), throwsA(isA<ApiException>()));
    expect(() => OtpRepositoryImpl(OtpRemoteDataSource(ApiClient(cTimeout))).resend('a@b.c'), throwsA(isA<ApiException>()));
  });
}
