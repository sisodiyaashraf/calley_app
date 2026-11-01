import '../entities/otp_verification.dart';
import '../repositories/otp_repository.dart';

/// Use case to verify entered OTP for a phone number.
class VerifyOtp {
  const VerifyOtp(this._repository);

  final OtpRepository _repository;

  Future<bool> call(OtpVerification verification) =>
      _repository.verify(verification);
}
