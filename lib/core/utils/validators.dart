import '../constants/app_strings.dart';

/// Form field validators for the Register (and future Sign In) screen.
/// Each validator returns null when valid, or an error string when invalid.
class Validators {
  Validators._();

  static String? name(String? value) {
    if (value == null || value.trim().length < 2) {
      return AppStrings.errNameRequired;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errEmailInvalid;
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.errEmailInvalid;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 8) {
      return AppStrings.errPasswordShort;
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().length != 10) {
      return AppStrings.errPhoneInvalid;
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
      return AppStrings.errPhoneInvalid;
    }
    return null;
  }
}
