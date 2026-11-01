import 'package:flutter/material.dart';
import '../../features/language/presentation/pages/choose_language_page.dart';
import '../../features/otp/presentation/pages/otp_page.dart';
import '../../features/register/presentation/pages/register_page.dart';
import '../../features/sign_in/presentation/pages/sign_in_page.dart';

/// Central named route identifiers.
class AppRoutes {
  AppRoutes._();

  static const String language = '/';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String signIn = '/sign-in';
}

/// Central application route generator and navigation helpers.
class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.language:
        return MaterialPageRoute(
          builder: (_) => const ChooseLanguagePage(),
          settings: settings,
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
          settings: settings,
        );
      case AppRoutes.otp:
        final phone = (settings.arguments as String?) ?? '+91';
        return MaterialPageRoute(
          builder: (_) => OtpPage(phoneNumber: phone),
          settings: settings,
        );
      case AppRoutes.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const ChooseLanguagePage(),
          settings: settings,
        );
    }
  }

  static void toRegister(BuildContext context) =>
      Navigator.pushNamed(context, AppRoutes.register);

  static void toSignIn(BuildContext context) =>
      Navigator.pushReplacementNamed(context, AppRoutes.signIn);

  static void toRegisterFromSignIn(BuildContext context) =>
      Navigator.pushReplacementNamed(context, AppRoutes.register);

  static void toOtp(BuildContext context, String phone) =>
      Navigator.pushNamed(context, AppRoutes.otp, arguments: phone);
}
