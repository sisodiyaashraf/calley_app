import '../../../../core/network/api_client.dart';
import '../../domain/entities/otp_verification.dart';

/// Remote data source executing OTP verification and resend requests via API.
class OtpRemoteDataSource {
  const OtpRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<bool> verify(OtpVerification verification) async {
    await _apiClient.post(
      '/auth/verify-otp',
      body: {
        'email': verification.email,
        'otp': verification.code,
      },
    );
    return true;
  }

  Future<bool> resend(String email) async {
    await _apiClient.post(
      '/auth/send-otp',
      body: {'email': email},
    );
    return true;
  }
}
