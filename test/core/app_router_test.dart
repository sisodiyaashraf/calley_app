import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/navigation/app_router.dart';
import 'package:calley_app/core/navigation/main_shell.dart';
import 'package:calley_app/core/navigation/nav_provider.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/features/app_drawer/domain/usecases/get_drawer_items.dart';
import 'package:calley_app/features/app_drawer/domain/usecases/logout_user.dart';
import 'package:calley_app/features/app_drawer/presentation/providers/drawer_provider.dart';
import 'package:calley_app/features/calling_lists/domain/entities/calling_list.dart';
import 'package:calley_app/features/calling_lists/domain/repositories/calling_list_repository.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/get_calling_lists.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/refresh_calling_lists.dart';
import 'package:calley_app/features/calling_lists/presentation/providers/calling_list_provider.dart';
import 'package:calley_app/features/dashboard/domain/entities/call_stats.dart';
import 'package:calley_app/features/dashboard/domain/entities/dashboard_info.dart';
import 'package:calley_app/features/dashboard/domain/repositories/dashboard_repository.dart';
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
import 'package:calley_app/features/static_screens/presentation/pages/static_screen_page.dart';
import 'package:calley_app/features/static_screens/presentation/pages/static_screens_page.dart';
import 'package:calley_app/features/static_screens/presentation/pages/sync_data_page.dart';

class _FakeDashRepo implements DashboardRepository {
  @override
  Future<DashboardInfo> getDashboardInfo() async => const DashboardInfo(cardTitle: AppStrings.loadNumberToCall, message: '', link: '');
  @override
  Future<CallStats> getStats(String listId, [String? listName]) async => const CallStats(listName: AppStrings.testList, totalCalls: 0, pending: 0, done: 0, scheduled: 0);
}

class _FakeListRepo implements CallingListRepository {
  @override
  Future<List<CallingList>> getLists() async => const [];
  @override
  Future<List<CallingList>> refresh() async => const [];
}

Widget _createApp(String initialRoute) {
  final lRepo = LanguageRepositoryImpl(const LanguageLocalDataSource());
  final rRepo = RegisterRepositoryImpl(const RegisterMockDataSource());
  final oRepo = OtpRepositoryImpl(const OtpMockDataSource());
  final sRepo = SignInRepositoryImpl(const SignInMockDataSource());
  final hRepo = HomeRepositoryImpl(const HomeMockDataSource());

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NavProvider()),
      ChangeNotifierProvider(create: (_) => LanguageProvider(getLanguages: GetLanguages(lRepo), selectLanguage: SelectLanguage(lRepo))),
      ChangeNotifierProvider(create: (_) => RegisterProvider(registerUser: RegisterUser(rRepo))),
      ChangeNotifierProvider(create: (_) => OtpProvider(verifyOtp: VerifyOtp(oRepo), resendOtp: ResendOtp(oRepo))),
      ChangeNotifierProvider(create: (_) => SignInProvider(signInUser: SignInUser(sRepo))),
      ChangeNotifierProvider(create: (_) => HomeProvider(getUserProfile: GetUserProfile(hRepo))),
      ChangeNotifierProvider(create: (_) => DashboardProvider(getDashboardInfo: GetDashboardInfo(_FakeDashRepo()), getCallStats: GetCallStats(_FakeDashRepo()))),
      ChangeNotifierProvider(create: (_) => CallingListProvider(getCallingLists: GetCallingLists(_FakeListRepo()), refreshCallingLists: RefreshCallingLists(_FakeListRepo()))),
      ChangeNotifierProvider(create: (_) => DrawerProvider(getDrawerItems: const GetDrawerItems(), logoutUser: LogoutUser(sRepo))),
    ],
    child: MaterialApp(key: ValueKey(initialRoute), theme: AppTheme.light, initialRoute: initialRoute, onGenerateRoute: AppRouter.onGenerateRoute),
  );
}

void main() {
  testWidgets('router routes to all configured routes', (tester) async {
    await tester.pumpWidget(_createApp(AppRoutes.language));
    await tester.pumpAndSettle();
    expect(find.byType(ChooseLanguagePage), findsOneWidget);

    await tester.pumpWidget(_createApp(AppRoutes.register));
    await tester.pumpAndSettle();
    expect(find.byType(RegisterPage), findsOneWidget);

    await tester.pumpWidget(_createApp(AppRoutes.otp));
    await tester.pumpAndSettle();
    expect(find.byType(OtpPage), findsOneWidget);

    await tester.pumpWidget(_createApp(AppRoutes.signIn));
    await tester.pumpAndSettle();
    expect(find.byType(SignInPage), findsOneWidget);

    await tester.pumpWidget(_createApp(AppRoutes.home));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);

    await tester.pumpWidget(_createApp(AppRoutes.main));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.byType(MainShell), findsOneWidget);

    await tester.pumpWidget(_createApp(AppRoutes.settings));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);

    await tester.pumpWidget(_createApp(AppRoutes.allScreens));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.byType(StaticScreensPage), findsOneWidget);

    await tester.pumpWidget(_createApp(AppRoutes.syncData));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.byType(SyncDataPage), findsOneWidget);

    await tester.pumpWidget(_createApp(AppRoutes.staticScreen));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.byType(StaticScreenPage), findsOneWidget);
  });
}
