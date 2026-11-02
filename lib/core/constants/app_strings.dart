/// All user-visible strings for the Calley app.
library;

class AppStrings {
  AppStrings._();

  // Screen 1 – Language
  static const String chooseYourLanguage = 'Choose Your Language', select = 'Select';
  static const String languageSelectedPrefix = 'Language selected: ';

  // Screen 2 – Register
  static const String welcome = 'Welcome!', registerSubtitle = 'Please register to continue';
  static const String hintName = 'Name', hintEmail = 'Email address', hintPassword = 'Password';
  static const String hintCountryCode = '+91', hintMobile = 'Mobile number';
  static const String termsPrefix = 'I agree to the ', termsLink = 'Terms and Conditions';
  static const String signInPrompt = 'Already have an account? ', signInLink = 'Sign In';
  static const String signUp = 'Sign Up', countryCodeIndia = '🇮🇳  +91';

  // Screen 2 – Errors & Success
  static const String errNameRequired = 'Name must be at least 2 characters';
  static const String errEmailInvalid = 'Enter a valid email address';
  static const String errPasswordShort = 'Password must be at least 8 characters';
  static const String errPhoneInvalid = 'Enter a valid 10-digit mobile number';
  static const String errTermsRequired = 'Please accept the Terms and Conditions';
  static const String errGeneric = 'Something went wrong. Please try again.';
  static const String registerSuccess = 'Registration successful!';

  // Screen 3 – OTP
  static const String otpTitle = 'Whatsapp OTP\nVerification';
  static const String otpDescription =
      'Please ensure that the email id mentioned is valid as we have sent an OTP to your email.';
  static const String resendPrompt = "Didn't receive OTP code? ", resendOtp = 'Resend OTP';
  static const String resendOtpIn = 'Resend OTP in ', verify = 'Verify';
  static const String errInvalidOtp = 'Invalid OTP code. Please try again.';
  static const String otpResentSuccess = 'OTP code resent successfully.';
  static const String wrongNumberPrompt = 'Wrong number? ', changeNumberLink = 'Change Number';

  // Screen 4 – Sign In
  static const String welcomeSignIn = 'Welcome', signInSubtitle = 'Please sign-in to continue';
  static const String forgotPassword = 'Forgot Password?', signUpPrompt = "Don't have an account? ";
  static const String signInButton = 'Sign In', signedInSuccess = 'Signed in successfully!';
  static const String forgotPasswordInfo = 'Password reset instructions will be sent to your email.';

  // Screen 5 – Home
  static const String helloPrefix = 'Hello ', defaultProfileTitle = 'Calley Personal';
  static const String homeInfoNotice =
      'If you are here for the first time then ensure that you have uploaded the list to call from calley Web Panel hosted on https://app.getcalley.com';
  static const String startCallingNow = 'Star Calling Now';
  static const String videoTappedMessage = 'Video tutorial tapped';
  static const String whatsAppTappedMessage = 'WhatsApp support tapped';
  static const String startCallingTappedMessage = 'Start Calling Now tapped';

  // Dashboard & Navigation
  static const String dashboardTitle = 'Dashboard', welcomeToCalley = 'Welcome to Calley!';
  static const String loadNumberToCall = 'LOAD NUMBER TO CALL';
  static const String loadNumberMessage =
      'Visit https://app.getcalley.com to upload numbers that you wish to call using Calley Mobile App.';
  static const String loadNumberUrl = 'https://app.getcalley.com';
  static const String loadNumberPrefix = 'Visit ';
  static const String loadNumberSuffix = ' to upload numbers that you wish to call using Calley Mobile App.';
  static const String tabHome = 'Home', tabContacts = 'Contacts', tabPlay = 'Play';
  static const String tabIncoming = 'Incoming Calls', tabSchedule = 'Schedule';
  static const String actionMenu = 'Menu', actionSupport = 'Support', actionNotifications = 'Notifications';
  static const String actionLink = 'Opening link: https://app.getcalley.com';
  static const String actionWhatsApp = 'Opening WhatsApp support...';
  static const String actionStartCalling = 'Starting calling session...';

  // Settings & Calling Lists
  static const String settingsTitle = 'Setting', profileSettingsBand = 'PROFILE SETTINGS';
  static const String appLanguage = 'App Language', changePassword = 'Change Password';
  static const String callingLists = 'Calling Lists', parentAccountPrefix = 'Parent Account: ';
  static const String subscriptionPrefix = 'Current Subscription: ';
  static const String callingListsBand = 'CALLING LISTS', selectCallingList = 'Select Calling List';
  static const String refresh = 'Refresh', noCallingLists = 'No calling lists yet';
  static const String testList = 'Test List';

  // Selected Calling List Dashboard State
  static const String callsCaps = 'CALLS', callsLower = 'Calls';
  static const String pendingLabel = 'Pending', doneLabel = 'Done', scheduleLabel = 'Schedule';

  // Side Navigation Drawer
  static const String drawerGettingStarted = 'Getting Started', drawerSyncData = 'Sync Data';
  static const String drawerGamification = 'Gamification', drawerSendLogs = 'Send Logs';
  static const String drawerSettings = 'Settings', drawerHelp = 'Help?';
  static const String drawerCancelSubscription = 'Cancel Subscription', drawerAppInfo = 'App Info';
  static const String drawerAboutUs = 'About Us', drawerPrivacyPolicy = 'Privacy Policy';
  static const String drawerVersionPrefix = 'Version', drawerDefaultVersion = '1.01.52';
  static const String drawerShareApp = 'Share App', drawerLogout = 'Logout';
  static const String drawerShareText = 'Check out Calley Automatic Call Dialer: https://www.getcalley.com';
  static const String logoutConfirmTitle = 'Logout', logoutConfirmMessage = 'Are you sure you want to logout?';
  static const String cancel = 'Cancel', retry = 'Retry';
}
