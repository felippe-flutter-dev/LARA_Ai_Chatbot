import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemeDark {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.darkBg100,
      // Fundo principal
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryDark,
        brightness: Brightness.dark,
        primary: AppColors.primaryDark,
        surface: AppColors.darkBg200,
        // Superfície de cards/inputs
        onSurface: AppColors.textOnDark,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.darkElevated),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBg200,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.25),
        surfaceTintColor: AppColors.darkBg200,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),
      textTheme: TextTheme(
        /// [FontSizes.headlineLarge]
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: AppColors.textOnDark,
        ),

        /// [FontSizes.headlineMedium]
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryMain,
        ),

        /// [FontSizes.bodyLarge]
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textOnDark.withValues(alpha: 0.9),
        ),

        /// [FontSizes.bodySmall]
        bodySmall: TextStyle(fontSize: 12, color: AppColors.gray400),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkBg200,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
