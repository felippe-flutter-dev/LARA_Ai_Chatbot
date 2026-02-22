import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color get primaryMain => Color(0xFFA73CFF);

  static Color get primaryDark => Color(0xFF6200EE);

  static Color get secondaryMain => Color(0xFFECDAFF);

  static Color get surfaceOverlay => Color(0xFF2C2C2C);

  static Color get success => Color(0xFF00C584);

  static Color get error => Color(0xFFE88787);

  static Color get gray50 => Color(0xFFFBFBFC);

  static Color get gray100 => Color(0xFFE5E7EB);

  static Color get gray200 => Color(0xFFDEDEDE);

  static Color get gray400 => Color(0xFFA0A0A0);

  static Color get gray500 => Color(0xFF5F6978);

  static Color get gray700 => Color(0xFF364153);

  static Color get gray900 => Color(0xFF101828);

  static Color get darkBg100 => Color(0xFF1A1A1A);

  static Color get darkBg200 => Color(0xFF1E1E1E);

  static Color get darkBg300 => Color(0xFF252525);

  static Color get darkElevated => Color(0xFF2C2C2C);

  static Color get textOnDark => Color(0xFFE1E1E1);

  static LinearGradient get purpleGradient => LinearGradient(
    colors: [Color(0xFFAB46FE), Color(0xFF9811FA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
