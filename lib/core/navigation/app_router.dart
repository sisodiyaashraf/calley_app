import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/dashboard/presentation/pages/dashboard_chart_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_load_page.dart';
import '../../features/dashboard/presentation/pages/static_chart_page.dart';
import '../../features/home/presentation/pages/first_time_home_page.dart';
import '../../features/language/presentation/pages/choose_language_page.dart';
import '../../features/otp/presentation/pages/otp_page.dart';
import '../../features/register/presentation/pages/register_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/sign_in/presentation/pages/sign_in_page.dart';
import '../../features/static_screens/domain/entities/static_screen_data.dart';
import '../../features/static_screens/presentation/pages/static_screen_page.dart';
import '../../features/static_screens/presentation/pages/static_screens_page.dart';
import '../../features/static_screens/presentation/pages/sync_data_page.dart';
import 'main_shell.dart';
import 'nav_provider.dart';

/// Central named route identifiers.
class AppRoutes {
  AppRoutes._();

  static const String language = '/';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String signIn = '/sign-in';
  static const String home = '/home';
  static const String main = '/main';
  static const String dashboard = '/dashboard';
  static const String dashboardLoad = '/dashboard-load';
  static const String dashboardChart = '/dashboard-chart';
  static const String staticChart = '/static-chart';
  static const String settings = '/settings';
  static const String syncData = '/sync-data';
  static const String staticScreen = '/static-screen';
  static const String allScreens = '/all-screens';
}

/// Central application route generator and navigation helpers.
class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.language: return MaterialPageRoute(builder: (_) => const ChooseLanguagePage(), settings: settings);
      case AppRoutes.register: return MaterialPageRoute(builder: (_) => const RegisterPage(), settings: settings);
      case AppRoutes.otp:
        final phone = (settings.arguments as String?) ?? '+91';
        return MaterialPageRoute(builder: (_) => OtpPage(phoneNumber: phone), settings: settings);
      case AppRoutes.signIn: return MaterialPageRoute(builder: (_) => const SignInPage(), settings: settings);
      case AppRoutes.home: return MaterialPageRoute(builder: (_) => const FirstTimeHomePage(), settings: settings);
      case AppRoutes.main:
      case AppRoutes.dashboard: return MaterialPageRoute(builder: (_) => const MainShell(), settings: settings);
      case AppRoutes.dashboardLoad: return MaterialPageRoute(builder: (_) => const DashboardLoadPage(), settings: settings);
      case AppRoutes.dashboardChart: return MaterialPageRoute(builder: (_) => const DashboardChartPage(), settings: settings);
      case AppRoutes.staticChart: return MaterialPageRoute(builder: (_) => const StaticChartPage(), settings: settings);
      case AppRoutes.settings: return MaterialPageRoute(builder: (_) => const SettingsPage(), settings: settings);
      case AppRoutes.syncData: return MaterialPageRoute(builder: (_) => const SyncDataPage(), settings: settings);
      case AppRoutes.staticScreen:
        return MaterialPageRoute(builder: (_) => StaticScreenPage(data: settings.arguments as StaticScreenData?), settings: settings);
      case AppRoutes.allScreens: return MaterialPageRoute(builder: (_) => const StaticScreensPage(), settings: settings);
      default: return MaterialPageRoute(builder: (_) => const ChooseLanguagePage(), settings: settings);
    }
  }

  static void toRegister(BuildContext context) => Navigator.pushNamed(context, AppRoutes.register);
  static void toSignIn(BuildContext context) => Navigator.pushNamed(context, AppRoutes.signIn);
  static void toRegisterFromSignIn(BuildContext context) => Navigator.pushReplacementNamed(context, AppRoutes.register);
  static void toOtp(BuildContext context, String phone) => Navigator.pushReplacementNamed(context, AppRoutes.otp, arguments: phone);
  static void toHome(BuildContext context) => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
  static void toLanguage(BuildContext context) => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.language, (_) => false);
  static void toMain(BuildContext context) => Navigator.pushReplacementNamed(context, AppRoutes.main);
  static void toSettings(BuildContext context) => Navigator.pushNamed(context, AppRoutes.settings);
  static void toStaticChart(BuildContext context) => Navigator.pushNamed(context, AppRoutes.staticChart);

  static void toDashboardLoad(BuildContext context) {
    try {
      final nav = context.read<NavProvider>();
      nav.setShowChart(false);
      nav.select(2);
    } catch (_) {}
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.main, (_) => false);
  }

  static void toDashboardChart(BuildContext context) {
    try {
      final nav = context.read<NavProvider>();
      nav.setShowChart(true);
      nav.select(2);
    } catch (_) {}
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
