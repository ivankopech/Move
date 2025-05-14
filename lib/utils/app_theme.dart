import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_button_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: appColors.primaryColor,
      scaffoldBackgroundColor: appColors.backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: appColors.primaryColor,
        primary: appColors.primaryColor,
        secondary: appColors.primaryHoverColor,
        background: appColors.backgroundColor,
        surface: appColors.surfaceColor,
        error: appColors.errorColor,
        brightness: Brightness.light,
      ),
      textTheme:  TextTheme(
        headlineMedium: appTextStyles.headline,
        titleMedium: appTextStyles.subhead,
        bodyMedium: appTextStyles.body,
        bodySmall: appTextStyles.caption,
        labelLarge: appTextStyles.button,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppButtonStyles.primaryButton,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: AppButtonStyles.secondaryButton,
      ),
      // Podés agregar otros estilos aquí como AppBar, InputDecoration, etc.
    );
  }
}
