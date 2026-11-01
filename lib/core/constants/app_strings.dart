/// All user-visible strings for Screens 1 & 2.
library;

class AppStrings {
  AppStrings._();

  // ── Screen 1 ─────────────────────────────────────────────────────────
  static const String chooseYourLanguage = 'Choose Your Language';
  static const String select = 'Select';
  static const String languageSelectedPrefix = 'Language selected: ';

  // ── Screen 2 – Register ──────────────────────────────────────────────
  static const String welcome = 'Welcome!';
  static const String registerSubtitle = 'Please register to continue';
  static const String hintName = 'Name';
  static const String hintEmail = 'Email address';
  static const String hintPassword = 'Password';
  static const String hintCountryCode = '+91';
  static const String hintMobile = 'Mobile number';
  static const String termsPrefix = 'I agree to the ';
  static const String termsLink = 'Terms and Conditions';
  static const String signInPrompt = 'Already have an account? ';
  static const String signInLink = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String countryCodeIndia = '🇮🇳  +91';

  // Validation messages
  static const String errNameRequired = 'Name must be at least 2 characters';
  static const String errEmailInvalid = 'Enter a valid email address';
  static const String errPasswordShort = 'Password must be at least 8 characters';
  static const String errPhoneInvalid = 'Enter a valid 10-digit mobile number';
  static const String errTermsRequired = 'Please accept the Terms and Conditions';
  static const String errGeneric = 'Something went wrong. Please try again.';

  // Register success
  static const String registerSuccess = 'Registration successful!';
}
