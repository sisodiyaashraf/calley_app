import '../repositories/otp_repository.dart';

/// Use case to request OTP resend for a phone number.
class ResendOtp {
  const ResendOtp(this._repository);

  final OtpRepository _repository;

  Future<bool> call(String phone) => _repository.resend(phone);
}
