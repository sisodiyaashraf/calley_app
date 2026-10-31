import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Root MaterialTheme configuration for the Calley app.
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.pageBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.pageBackground,
        ),
        splashFactory: InkRipple.splashFactory,
      );
}
