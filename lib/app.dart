import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'core/navigation/app_router.dart';
import 'core/navigation/nav_provider.dart';
import 'core/network/api_client.dart';
import 'core/session/session.dart';
import 'core/theme/app_theme.dart';
import 'features/app_drawer/domain/usecases/get_drawer_items.dart';
import 'features/app_drawer/domain/usecases/logout_user.dart';
import 'features/app_drawer/presentation/providers/drawer_provider.dart';
import 'features/calling_lists/data/datasources/calling_list_remote_data_source.dart';
import 'features/calling_lists/data/repositories/calling_list_repository_impl.dart';
import 'features/calling_lists/domain/usecases/get_calling_lists.dart';
import 'features/calling_lists/domain/usecases/refresh_calling_lists.dart';
import 'features/calling_lists/presentation/providers/calling_list_provider.dart';
import 'features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'features/dashboard/domain/usecases/get_call_stats.dart';
import 'features/dashboard/domain/usecases/get_dashboard_info.dart';
import 'features/dashboard/presentation/providers/dashboard_provider.dart';
import 'features/home/data/datasources/home_mock_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/usecases/get_user_profile.dart';
import 'features/home/presentation/providers/home_provider.dart';
import 'features/language/data/datasources/language_local_data_source.dart';
import 'features/language/data/repositories/language_repository_impl.dart';
import 'features/language/domain/usecases/get_languages.dart';
import 'features/language/domain/usecases/select_language.dart';
import 'features/language/presentation/providers/language_provider.dart';
import 'features/otp/data/datasources/otp_mock_data_source.dart';
import 'features/otp/data/repositories/otp_repository_impl.dart';
import 'features/otp/domain/usecases/resend_otp.dart';
import 'features/otp/domain/usecases/verify_otp.dart';
import 'features/otp/presentation/providers/otp_provider.dart';
import 'features/register/data/datasources/register_mock_data_source.dart';
import 'features/register/data/repositories/register_repository_impl.dart';
import 'features/register/domain/usecases/register_user.dart';
import 'features/register/presentation/providers/register_provider.dart';
import 'features/sign_in/data/datasources/sign_in_mock_data_source.dart';
import 'features/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'features/sign_in/domain/usecases/sign_in_user.dart';
import 'features/sign_in/presentation/providers/sign_in_provider.dart';

/// Root of the widget tree with dependency graph composition.
class CalleyApp extends StatelessWidget {
  const CalleyApp({super.key, this.initialRoute = AppRoutes.language});

  final String initialRoute;
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final session = Session.instance, apiClient = ApiClient(http.Client());
    final langRepo = LanguageRepositoryImpl(const LanguageLocalDataSource());
    final regRepo = RegisterRepositoryImpl(const RegisterMockDataSource()), otpRepo = OtpRepositoryImpl(const OtpMockDataSource());
    final signInRepo = SignInRepositoryImpl(const SignInMockDataSource()), homeRepo = HomeRepositoryImpl(const HomeMockDataSource());
    final dashRepo = DashboardRepositoryImpl(DashboardRemoteDataSource(apiClient: apiClient, session: session));
    final listRepo = CallingListRepositoryImpl(CallingListRemoteDataSource(apiClient: apiClient, session: session));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Session.instance),
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider(
          getLanguages: GetLanguages(langRepo), selectLanguage: SelectLanguage(langRepo),
          onConfirmed: (_) => navigatorKey.currentState?.pushNamed(AppRoutes.register),
        )),
        ChangeNotifierProvider(create: (_) {
          final p = RegisterProvider(registerUser: RegisterUser(regRepo));
          p.onRegistered = () => navigatorKey.currentState?.pushReplacementNamed(AppRoutes.otp, arguments: '${p.countryCode} ${p.phone}');
          return p;
        }),
        ChangeNotifierProvider(create: (_) => OtpProvider(verifyOtp: VerifyOtp(otpRepo), resendOtp: ResendOtp(otpRepo))),
        ChangeNotifierProvider(create: (_) => SignInProvider(signInUser: SignInUser(signInRepo))),
        ChangeNotifierProvider(create: (_) => HomeProvider(getUserProfile: GetUserProfile(homeRepo))),
        ChangeNotifierProvider(create: (_) => DashboardProvider(getDashboardInfo: GetDashboardInfo(dashRepo), getCallStats: GetCallStats(dashRepo))),
        ChangeNotifierProvider(create: (_) => CallingListProvider(getCallingLists: GetCallingLists(listRepo), refreshCallingLists: RefreshCallingLists(listRepo))),
        ChangeNotifierProvider(create: (_) => DrawerProvider(getDrawerItems: const GetDrawerItems(), logoutUser: LogoutUser(signInRepo))),
      ],
      child: MaterialApp(
        title: 'Calley', navigatorKey: navigatorKey, debugShowCheckedModeBanner: false,
        theme: AppTheme.light, initialRoute: initialRoute, onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
