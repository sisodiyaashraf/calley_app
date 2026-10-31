import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/language/data/datasources/language_local_data_source.dart';
import 'features/language/data/repositories/language_repository_impl.dart';
import 'features/language/domain/usecases/get_languages.dart';
import 'features/language/domain/usecases/select_language.dart';
import 'features/language/presentation/providers/language_provider.dart';
import 'features/language/presentation/pages/choose_language_page.dart';

/// Root of the widget tree.
///
/// Dependency graph assembled here (composition root):
///   LocalDataSource → RepositoryImpl → UseCases → Provider
///
/// [onLanguageConfirmed] callback on [LanguageProvider] is intentionally
/// left null here. Replace `null` with a Navigator push when Screen 2
/// (Register) is built.
class CalleyApp extends StatelessWidget {
  const CalleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ── Wire the dependency graph ──────────────────────────────────────
    final dataSource = const LanguageLocalDataSource();
    final repository = LanguageRepositoryImpl(dataSource);
    final getLanguages = GetLanguages(repository);
    final selectLanguage = SelectLanguage(repository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(
            getLanguages: getLanguages,
            selectLanguage: selectLanguage,
            // TODO(navigation): replace null with a push to RegisterPage
            // once Screen 2 is implemented.
            onConfirmed: null,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Calley',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const ChooseLanguagePage(),
      ),
    );
  }
}
