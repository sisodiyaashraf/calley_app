/// Value object representing OTP verification details.
class OtpVerification {
  const OtpVerification({
    required this.email,
    required this.code,
  });

  final String email;
  final String code;

  String get phone => email;
}
