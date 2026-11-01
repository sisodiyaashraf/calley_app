import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
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
  const CalleyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final languageRepo = LanguageRepositoryImpl(const LanguageLocalDataSource());
    final registerRepo = RegisterRepositoryImpl(const RegisterMockDataSource());
    final otpRepo = OtpRepositoryImpl(const OtpMockDataSource());
    final signInRepo = SignInRepositoryImpl(const SignInMockDataSource());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(
            getLanguages: GetLanguages(languageRepo),
            selectLanguage: SelectLanguage(languageRepo),
            onConfirmed: (_) =>
                navigatorKey.currentState?.pushNamed(AppRoutes.register),
          ),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) {
            final p = RegisterProvider(registerUser: RegisterUser(registerRepo));
            p.onRegistered = () {
              final phone = '${p.countryCode} ${p.phone}';
              navigatorKey.currentState
                  ?.pushNamed(AppRoutes.otp, arguments: phone);
            };
            return p;
          },
        ),
        ChangeNotifierProvider<OtpProvider>(
          create: (_) => OtpProvider(
            verifyOtp: VerifyOtp(otpRepo),
            resendOtp: ResendOtp(otpRepo),
          ),
        ),
        ChangeNotifierProvider<SignInProvider>(
          create: (_) => SignInProvider(
            signInUser: SignInUser(signInRepo),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Calley',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRoutes.language,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
