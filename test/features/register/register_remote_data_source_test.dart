import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:calley_app/core/network/api_client.dart';
import 'package:calley_app/core/network/api_exception.dart';
import 'package:calley_app/core/session/pending_registration.dart';
import 'package:calley_app/features/otp/domain/entities/otp_verification.dart';
import 'package:calley_app/features/otp/domain/repositories/otp_repository.dart';
import 'package:calley_app/features/register/data/datasources/register_remote_data_source.dart';
import 'package:calley_app/features/register/data/repositories/register_repository_impl.dart';
import 'package:calley_app/features/register/domain/entities/register_request.dart';

class _FakeClient extends http.BaseClient {
  _FakeClient(this._handler);
  final Future<http.Response> Function(http.BaseRequest) _handler;
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final res = await _handler(request);
    return http.StreamedResponse(Stream.value(utf8.encode(res.body)), res.statusCode);
  }
}

class _FakeOtpRepo implements OtpRepository {
  String? resentEmail;
  @override
  Future<bool> verify(OtpVerification verification) async => true;
  @override
  Future<bool> resend(String email) async { resentEmail = email; return true; }
}

void main() {
  const req = RegisterRequest(name: 'John', email: 'j@a.com', password: 'P1!', countryCode: '+91', phone: '123');

  test('RegisterRepositoryImpl success sends body, triggers OTP, saves pending registration', () async {
    final client = _FakeClient((r) async {
      final body = jsonDecode((r as http.Request).body);
      expect(body['username'], 'John');
      expect(body['email'], 'j@a.com');
      expect(body['password'], 'P1!');
      return http.Response('{"message": "User registered"}', 201);
    });
    final otpRepo = _FakeOtpRepo();
    final repo = RegisterRepositoryImpl(RegisterRemoteDataSource(ApiClient(client)), otpRepo);

    final ok = await repo.register(req);
    expect(ok, isTrue);
    expect(otpRepo.resentEmail, 'j@a.com');
    expect(PendingRegistration.email, 'j@a.com');
    expect(PendingRegistration.password, 'P1!');
  });

  test('RegisterRepositoryImpl 400 failure throws ApiException', () async {
    final client = _FakeClient((_) async => http.Response('{"message": "Error"}', 400));
    final repo = RegisterRepositoryImpl(RegisterRemoteDataSource(ApiClient(client)), _FakeOtpRepo());
    expect(() => repo.register(req), throwsA(isA<ApiException>()));
  });

  test('RegisterRepositoryImpl timeout throws ApiException', () async {
    final client = _FakeClient((_) => throw TimeoutException('timeout'));
    final repo = RegisterRepositoryImpl(RegisterRemoteDataSource(ApiClient(client)), _FakeOtpRepo());
    expect(() => repo.register(req), throwsA(isA<ApiException>()));
  });
}
