import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/navigation/app_router.dart';
import 'package:calley_app/core/navigation/main_shell.dart';
import 'package:calley_app/core/navigation/nav_provider.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/features/app_drawer/domain/usecases/get_drawer_items.dart';
import 'package:calley_app/features/app_drawer/domain/usecases/logout_user.dart';
import 'package:calley_app/features/app_drawer/presentation/providers/drawer_provider.dart';
import 'package:calley_app/features/calling_lists/data/datasources/calling_list_mock_data_source.dart';
import 'package:calley_app/features/calling_lists/data/repositories/calling_list_repository_impl.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/get_calling_lists.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/refresh_calling_lists.dart';
import 'package:calley_app/features/calling_lists/presentation/providers/calling_list_provider.dart';
import 'package:calley_app/features/dashboard/data/datasources/dashboard_mock_data_source.dart';
import 'package:calley_app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_call_stats.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_dashboard_info.dart';
import 'package:calley_app/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:calley_app/features/home/data/datasources/home_mock_data_source.dart';
import 'package:calley_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:calley_app/features/home/domain/usecases/get_user_profile.dart';
import 'package:calley_app/features/home/presentation/pages/home_page.dart';
import 'package:calley_app/features/home/presentation/providers/home_provider.dart';
import 'package:calley_app/features/language/data/datasources/language_local_data_source.dart';
import 'package:calley_app/features/language/data/repositories/language_repository_impl.dart';
import 'package:calley_app/features/language/domain/usecases/get_languages.dart';
import 'package:calley_app/features/language/domain/usecases/select_language.dart';
import 'package:calley_app/features/language/presentation/pages/choose_language_page.dart';
import 'package:calley_app/features/language/presentation/providers/language_provider.dart';
import 'package:calley_app/features/otp/data/datasources/otp_mock_data_source.dart';
import 'package:calley_app/features/otp/data/repositories/otp_repository_impl.dart';
import 'package:calley_app/features/otp/domain/usecases/resend_otp.dart';
import 'package:calley_app/features/otp/domain/usecases/verify_otp.dart';
import 'package:calley_app/features/otp/presentation/pages/otp_page.dart';
import 'package:calley_app/features/otp/presentation/providers/otp_provider.dart';
import 'package:calley_app/features/register/data/datasources/register_mock_data_source.dart';
import 'package:calley_app/features/register/data/repositories/register_repository_impl.dart';
import 'package:calley_app/features/register/domain/usecases/register_user.dart';
import 'package:calley_app/features/register/presentation/pages/register_page.dart';
import 'package:calley_app/features/register/presentation/providers/register_provider.dart';
import 'package:calley_app/features/settings/presentation/pages/settings_page.dart';
import 'package:calley_app/features/sign_in/data/datasources/sign_in_mock_data_source.dart';
import 'package:calley_app/features/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:calley_app/features/sign_in/domain/usecases/sign_in_user.dart';
import 'package:calley_app/features/sign_in/presentation/pages/sign_in_page.dart';
import 'package:calley_app/features/sign_in/presentation/providers/sign_in_provider.dart';

Widget _createApp(String initialRoute) {
  final lRepo = LanguageRepositoryImpl(const LanguageLocalDataSource());
  final rRepo = RegisterRepositoryImpl(const RegisterMockDataSource());
  final oRepo = OtpRepositoryImpl(const OtpMockDataSource());
  final sRepo = SignInRepositoryImpl(const SignInMockDataSource());
  final hRepo = HomeRepositoryImpl(const HomeMockDataSource());
  final dRepo = DashboardRepositoryImpl(const DashboardMockDataSource());
  final cRepo = CallingListRepositoryImpl(const CallingListMockDataSource());

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NavProvider()),
      ChangeNotifierProvider(create: (_) => LanguageProvider(getLanguages: GetLanguages(lRepo), selectLanguage: SelectLanguage(lRepo))),
      ChangeNotifierProvider(create: (_) => RegisterProvider(registerUser: RegisterUser(rRepo))),
      ChangeNotifierProvider(create: (_) => OtpProvider(verifyOtp: VerifyOtp(oRepo), resendOtp: ResendOtp(oRepo))),
      ChangeNotifierProvider(create: (_) => SignInProvider(signInUser: SignInUser(sRepo))),
      ChangeNotifierProvider(create: (_) => HomeProvider(getUserProfile: GetUserProfile(hRepo))),
      ChangeNotifierProvider(create: (_) => DashboardProvider(getDashboardInfo: GetDashboardInfo(dRepo), getCallStats: GetCallStats(dRepo))),
      ChangeNotifierProvider(create: (_) => CallingListProvider(getCallingLists: GetCallingLists(cRepo), refreshCallingLists: RefreshCallingLists(cRepo))),
      ChangeNotifierProvider(create: (_) => DrawerProvider(getDrawerItems: const GetDrawerItems(), logoutUser: LogoutUser(sRepo))),
    ],
    child: MaterialApp(theme: AppTheme.light, initialRoute: initialRoute, onGenerateRoute: AppRouter.onGenerateRoute),
  );
}

void main() {
  testWidgets('router routes to ChooseLanguagePage for /', (tester) async {
    await tester.pumpWidget(_createApp(AppRoutes.language));
    await tester.pumpAndSettle();
    expect(find.byType(ChooseLanguagePage), findsOneWidget);
  });

  testWidgets('router routes to RegisterPage for /register', (tester) async {
    await tester.pumpWidget(_createApp(AppRoutes.register));
    await tester.pumpAndSettle();
    expect(find.byType(RegisterPage), findsOneWidget);
  });

  testWidgets('router routes to OtpPage for /otp', (tester) async {
    await tester.pumpWidget(_createApp(AppRoutes.otp));
    await tester.pumpAndSettle();
    expect(find.byType(OtpPage), findsOneWidget);
  });

  testWidgets('router routes to SignInPage for /sign-in', (tester) async {
    await tester.pumpWidget(_createApp(AppRoutes.signIn));
    await tester.pumpAndSettle();
    expect(find.byType(SignInPage), findsOneWidget);
  });

  testWidgets('router routes to HomePage for /home', (tester) async {
    await tester.pumpWidget(_createApp(AppRoutes.home));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('router routes to MainShell for /main', (tester) async {
    await tester.pumpWidget(_createApp(AppRoutes.main));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.byType(MainShell), findsOneWidget);
  });

  testWidgets('router routes to SettingsPage for /settings', (tester) async {
    await tester.pumpWidget(_createApp(AppRoutes.settings));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);
  });
}
