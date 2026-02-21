import 'package:flutter/material.dart';
import 'app_colors.dart'; // Certifique-se de que o path está correto

class AppThemeLight {
  static ThemeData get theme {
    const String fontFamily = 'Roboto';

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: AppColors.gray50,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryMain,
        primary: AppColors.primaryMain,
        secondary: AppColors.secondaryMain,
        surface: Colors.white,
        error: AppColors.error,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.gray50,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.25),
        surfaceTintColor: AppColors.gray50,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.gray500),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900, // Roboto-Bold (Peso 900 no YAML)
          color: AppColors.gray900,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700, // Roboto-SemiBold (Peso 700 no YAML)
          color: AppColors.primaryMain,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400, // Roboto-Regular
          color: AppColors.gray700,
        ),
        bodySmall: TextStyle(fontSize: 12, color: AppColors.gray500),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryMain,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
