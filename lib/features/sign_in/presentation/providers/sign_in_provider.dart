import 'package:flutter/foundation.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entities/sign_in_request.dart';
import '../../domain/usecases/sign_in_user.dart';

/// Manages form state and authentication for the Sign In screen.
class SignInProvider extends ChangeNotifier {
  SignInProvider({
    required SignInUser signInUser,
    this.onSignedIn,
  }) : _signInUser = signInUser;

  final SignInUser _signInUser;
  VoidCallback? onSignedIn;

  String email = '';
  String password = '';
  String? emailError;
  String? passwordError;
  String? generalError;
  bool isLoading = false;

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

  bool validate() {
    emailError = Validators.email(email);
    passwordError = Validators.password(password);
    notifyListeners();
    return emailError == null && passwordError == null;
  }

  Future<bool> submit() async {
    if (!validate()) return false;
    isLoading = true;
    generalError = null;
    notifyListeners();
    try {
      final request = SignInRequest(
        email: email.trim(),
        password: password,
      );
      final success = await _signInUser(request);
      if (success) {
        onSignedIn?.call();
        return true;
      }
      generalError = AppStrings.errGeneric;
      return false;
    } catch (_) {
      generalError = AppStrings.errGeneric;
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
