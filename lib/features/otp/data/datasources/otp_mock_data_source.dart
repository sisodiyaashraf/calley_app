import '../../domain/entities/otp_verification.dart';

/// Simulated OTP data source with simulated network delay.
class OtpMockDataSource {
  const OtpMockDataSource();

  Future<bool> verify(OtpVerification verification) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return verification.code.length == 6 &&
        RegExp(r'^\d{6}$').hasMatch(verification.code);
  }

  Future<bool> resend(String phone) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return true;
  }
}
