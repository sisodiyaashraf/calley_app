/// All user-visible strings for Screens 1, 2, 3, and 4.
library;

class AppStrings {
  AppStrings._();

  // Screen 1 – Language
  static const String chooseYourLanguage = 'Choose Your Language';
  static const String select = 'Select';
  static const String languageSelectedPrefix = 'Language selected: ';

  // Screen 2 – Register
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

  // Screen 2 – Errors & Success
  static const String errNameRequired = 'Name must be at least 2 characters';
  static const String errEmailInvalid = 'Enter a valid email address';
  static const String errPasswordShort =
      'Password must be at least 8 characters';
  static const String errPhoneInvalid = 'Enter a valid 10-digit mobile number';
  static const String errTermsRequired =
      'Please accept the Terms and Conditions';
  static const String errGeneric = 'Something went wrong. Please try again.';
  static const String registerSuccess = 'Registration successful!';

  // Screen 3 – OTP
  static const String otpTitle = 'Whatsapp OTP\nVerification';
  static const String otpDescription =
      'Please ensure that the email id mentioned is valid as we have sent an OTP to your email.';
  static const String resendPrompt = "Didn't receive OTP code? ";
  static const String resendOtp = 'Resend OTP';
  static const String resendOtpIn = 'Resend OTP in ';
  static const String verify = 'Verify';
  static const String errInvalidOtp = 'Invalid OTP code. Please try again.';
  static const String otpResentSuccess = 'OTP code resent successfully.';

  // Screen 4 – Sign In
  static const String welcomeSignIn = 'Welcome';
  static const String signInSubtitle = 'Please sign-in to continue';
  static const String forgotPassword = 'Forgot Password?';
  static const String signUpPrompt = "Don't have an account? ";
  static const String signInButton = 'Sign In';
  static const String signedInSuccess = 'Signed in successfully!';
  static const String forgotPasswordInfo =
      'Password reset instructions will be sent to your email.';
}
