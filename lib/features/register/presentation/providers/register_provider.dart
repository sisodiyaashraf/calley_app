import 'package:flutter/foundation.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entities/register_request.dart';
import '../../domain/usecases/register_user.dart';

/// Manages form state and submission for the Register screen.
class RegisterProvider extends ChangeNotifier {
  RegisterProvider({required RegisterUser registerUser, this.onRegistered})
    : _registerUser = registerUser;

  final RegisterUser _registerUser;
  VoidCallback? onRegistered;

  // Field values
  String name = '';
  String email = '';
  String password = '';
  String countryCode = '+91';
  String phone = '';
  bool agreedToTerms = false;
  bool isLoading = false;

  // Error messages (null = valid)
  String? nameError;
  String? emailError;
  String? passwordError;
  String? phoneError;
  String? termsError;
  String? generalError;

  void setName(String v) {
    name = v;
    nameError = null;
    notifyListeners();
  }

  void setEmail(String v) {
    email = v;
    emailError = null;
    notifyListeners();
  }

  void setPassword(String v) {
    password = v;
    passwordError = null;
    notifyListeners();
  }

  void setPhone(String v) {
    phone = v;
    phoneError = null;
    notifyListeners();
  }

  void toggleTerms() {
    agreedToTerms = !agreedToTerms;
    termsError = null;
    notifyListeners();
  }

  /// Validates all fields; returns true when valid.
  bool validate() {
    nameError = Validators.name(name);
    emailError = Validators.email(email);
    passwordError = Validators.password(password);
    phoneError = Validators.phone(phone);
    termsError = agreedToTerms ? null : AppStrings.errTermsRequired;
    notifyListeners();
    return nameError == null &&
        emailError == null &&
        passwordError == null &&
        phoneError == null &&
        termsError == null;
  }

  /// Validates and, if valid, calls the use-case then fires [onRegistered].
  Future<bool> submit() async {
    if (!validate()) return false;
    isLoading = true;
    generalError = null;
    notifyListeners();
    try {
      final request = RegisterRequest(
        name: name.trim(),
        email: email.trim(),
        password: password,
        countryCode: countryCode,
        phone: phone.trim(),
      );
      final success = await _registerUser(request);
      if (success) onRegistered?.call();
      return success;
    } catch (_) {
      generalError = AppStrings.errGeneric;
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
