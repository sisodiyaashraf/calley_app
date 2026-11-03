import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/network/api_exception.dart';
import '../../domain/entities/otp_verification.dart';
import '../../domain/usecases/resend_otp.dart';
import '../../domain/usecases/verify_otp.dart';

/// State management for OTP verification and resend countdown.
class OtpProvider extends ChangeNotifier {
  OtpProvider({required VerifyOtp verifyOtp, required ResendOtp resendOtp, this.onVerified})
      : _verifyOtp = verifyOtp, _resendOtp = resendOtp;

  final VerifyOtp _verifyOtp;
  final ResendOtp _resendOtp;
  VoidCallback? onVerified;
  List<String> digits = List.filled(6, '');
  String? error;
  bool isLoading = false;
  int resendCountdown = 0;
  Timer? _timer;

  bool get isComplete => digits.length == 6 && digits.every((d) => d.trim().isNotEmpty);
  bool get canResend => resendCountdown == 0 && !isLoading;
  String get code => digits.join();
  String get resendLabel => resendCountdown == 0
      ? AppStrings.resendOtp
      : '${AppStrings.resendOtpIn}0:${resendCountdown.toString().padLeft(2, '0')}';

  void setCode(String newCode) {
    final clean = newCode.replaceAll(RegExp(r'\D'), '');
    for (int i = 0; i < 6; i++) { digits[i] = i < clean.length ? clean[i] : ''; }
    error = null;
    notifyListeners();
  }

  void setError(String err) {
    error = err;
    notifyListeners();
  }

  void clearDigits() {
    digits = List.filled(6, '');
    error = null;
    notifyListeners();
  }

  Future<bool> verify(String email) async {
    if (!isComplete) return false;
    isLoading = true; error = null; notifyListeners();
    try {
      final ok = await _verifyOtp(OtpVerification(email: email, code: code));
      if (ok) { onVerified?.call(); return true; }
      error = AppStrings.errInvalidOtp;
      return false;
    } on AppException catch (e) {
      error = (e.statusCode != null && e.statusCode! >= 400 && e.statusCode! < 500)
          ? AppStrings.errInvalidOtp
          : AppStrings.errGeneric;
      return false;
    } catch (_) {
      error = AppStrings.errGeneric;
      return false;
    } finally {
      isLoading = false; notifyListeners();
    }
  }

  Future<bool> resend(String email) async {
    if (!canResend) return false;
    isLoading = true; error = null; notifyListeners();
    try {
      final ok = await _resendOtp(email);
      if (ok) { clearDigits(); _startCountdown(); }
      return ok;
    } catch (_) {
      error = AppStrings.errGeneric;
      return false;
    } finally {
      isLoading = false; notifyListeners();
    }
  }

  void _startCountdown() {
    _timer?.cancel();
    resendCountdown = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (resendCountdown > 1) { resendCountdown--; } else { resendCountdown = 0; t.cancel(); }
      notifyListeners();
    });
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }
}
