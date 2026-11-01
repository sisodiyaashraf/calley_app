import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/features/otp/domain/entities/otp_verification.dart';
import 'package:calley_app/features/otp/domain/repositories/otp_repository.dart';
import 'package:calley_app/features/otp/domain/usecases/resend_otp.dart';
import 'package:calley_app/features/otp/domain/usecases/verify_otp.dart';
import 'package:calley_app/features/otp/presentation/providers/otp_provider.dart';

class _SuccessOtpRepo implements OtpRepository {
  OtpVerification? lastVerification;
  String? lastResentPhone;

  @override
  Future<bool> verify(OtpVerification verification) async {
    lastVerification = verification;
    return verification.code == '123456';
  }

  @override
  Future<bool> resend(String phone) async {
    lastResentPhone = phone;
    return true;
  }
}

class _FailureOtpRepo implements OtpRepository {
  @override
  Future<bool> verify(OtpVerification verification) async {
    throw Exception('Verification failure');
  }

  @override
  Future<bool> resend(String phone) async {
    throw Exception('Resend failure');
  }
}

void main() {
  group('OtpProvider', () {
    test('initial state is correct', () {
      final repo = _SuccessOtpRepo();
      final provider = OtpProvider(
        verifyOtp: VerifyOtp(repo),
        resendOtp: ResendOtp(repo),
      );

      expect(provider.digits.length, 6);
      expect(provider.isComplete, isFalse);
      expect(provider.canResend, isTrue);
      expect(provider.resendCountdown, 0);
      expect(provider.resendLabel, AppStrings.resendOtp);
    });

    test('setCode correctly sets digits and isComplete', () {
      final repo = _SuccessOtpRepo();
      final provider = OtpProvider(
        verifyOtp: VerifyOtp(repo),
        resendOtp: ResendOtp(repo),
      );

      provider.setCode('123456');
      expect(provider.digits, ['1', '2', '3', '4', '5', '6']);
      expect(provider.isComplete, isTrue);
      expect(provider.code, '123456');

      provider.clearDigits();
      expect(provider.isComplete, isFalse);
      expect(provider.code, '');
    });

    test('verify with correct code calls use case and triggers onVerified',
        () async {
      final repo = _SuccessOtpRepo();
      bool verifiedCalled = false;
      final provider = OtpProvider(
        verifyOtp: VerifyOtp(repo),
        resendOtp: ResendOtp(repo),
        onVerified: () => verifiedCalled = true,
      );

      provider.setCode('123456');
      final result = await provider.verify('+91 9876543210');

      expect(result, isTrue);
      expect(verifiedCalled, isTrue);
      expect(repo.lastVerification?.phone, '+91 9876543210');
      expect(repo.lastVerification?.code, '123456');
      expect(provider.error, isNull);
    });

    test('verify with wrong code sets error', () async {
      final repo = _SuccessOtpRepo();
      final provider = OtpProvider(
        verifyOtp: VerifyOtp(repo),
        resendOtp: ResendOtp(repo),
      );

      provider.setCode('000000');
      final result = await provider.verify('+91 9876543210');

      expect(result, isFalse);
      expect(provider.error, AppStrings.errInvalidOtp);
    });

    test('resend clears digits and starts countdown', () async {
      final repo = _SuccessOtpRepo();
      final provider = OtpProvider(
        verifyOtp: VerifyOtp(repo),
        resendOtp: ResendOtp(repo),
      );

      provider.setCode('123456');
      final ok = await provider.resend('+91 9876543210');

      expect(ok, isTrue);
      expect(repo.lastResentPhone, '+91 9876543210');
      expect(provider.code, '');
      expect(provider.canResend, isFalse);
      expect(provider.resendCountdown, 30);
      expect(provider.resendLabel, contains('0:30'));

      provider.dispose();
    });

    test('failed verify with exception sets generic error', () async {
      final repo = _FailureOtpRepo();
      final provider = OtpProvider(
        verifyOtp: VerifyOtp(repo),
        resendOtp: ResendOtp(repo),
      );

      provider.setCode('123456');
      final ok = await provider.verify('+91 9876543210');

      expect(ok, isFalse);
      expect(provider.error, AppStrings.errGeneric);
    });
  });
}
