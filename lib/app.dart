import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/language/data/datasources/language_local_data_source.dart';
import 'features/language/data/repositories/language_repository_impl.dart';
import 'features/language/domain/usecases/get_languages.dart';
import 'features/language/domain/usecases/select_language.dart';
import 'features/language/presentation/pages/choose_language_page.dart';
import 'features/language/presentation/providers/language_provider.dart';
import 'features/register/data/datasources/register_mock_data_source.dart';
import 'features/register/data/repositories/register_repository_impl.dart';
import 'features/register/domain/usecases/register_user.dart';
import 'features/register/presentation/pages/register_page.dart';
import 'features/register/presentation/providers/register_provider.dart';

/// Root of the widget tree with dependency graph composition.
class CalleyApp extends StatelessWidget {
  const CalleyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final languageRepo = LanguageRepositoryImpl(
      const LanguageLocalDataSource(),
    );
    final registerRepo = RegisterRepositoryImpl(
      const RegisterMockDataSource(),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(
            getLanguages: GetLanguages(languageRepo),
            selectLanguage: SelectLanguage(languageRepo),
            onConfirmed: (_) => navigatorKey.currentState?.push(
              MaterialPageRoute(builder: (_) => const RegisterPage()),
            ),
          ),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider(
            registerUser: RegisterUser(registerRepo),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Calley',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const ChooseLanguagePage(),
      ),
    );
  }
}
