import '../entities/otp_verification.dart';

/// Repository interface for OTP verification and resending.
abstract class OtpRepository {
  Future<bool> verify(OtpVerification verification);
  Future<bool> resend(String email);
}
