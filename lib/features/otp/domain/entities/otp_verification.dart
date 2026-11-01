/// Value object representing OTP verification details.
class OtpVerification {
  const OtpVerification({
    required this.phone,
    required this.code,
  });

  final String phone;
  final String code;
}
