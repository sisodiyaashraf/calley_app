import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/navigation/app_router.dart';
import 'package:calley_app/core/theme/app_theme.dart';
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
import 'package:calley_app/features/sign_in/data/datasources/sign_in_mock_data_source.dart';
import 'package:calley_app/features/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:calley_app/features/sign_in/domain/usecases/sign_in_user.dart';
import 'package:calley_app/features/sign_in/presentation/pages/sign_in_page.dart';
import 'package:calley_app/features/sign_in/presentation/providers/sign_in_provider.dart';

Widget _createApp(String initialRoute) {
  final langRepo = LanguageRepositoryImpl(const LanguageLocalDataSource());
  final regRepo = RegisterRepositoryImpl(const RegisterMockDataSource());
  final otpRepo = OtpRepositoryImpl(const OtpMockDataSource());
  final signInRepo = SignInRepositoryImpl(const SignInMockDataSource());

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LanguageProvider(
          getLanguages: GetLanguages(langRepo),
          selectLanguage: SelectLanguage(langRepo),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => RegisterProvider(registerUser: RegisterUser(regRepo)),
      ),
      ChangeNotifierProvider(
        create: (_) => OtpProvider(
          verifyOtp: VerifyOtp(otpRepo),
          resendOtp: ResendOtp(otpRepo),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => SignInProvider(signInUser: SignInUser(signInRepo)),
      ),
    ],
    child: MaterialApp(
      theme: AppTheme.light,
      initialRoute: initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    ),
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
}
