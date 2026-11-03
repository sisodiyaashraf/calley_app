import '../repositories/otp_repository.dart';

/// Use case to request OTP resend for an email address.
class ResendOtp {
  const ResendOtp(this._repository);

  final OtpRepository _repository;

  Future<bool> call(String email) => _repository.resend(email);
}
