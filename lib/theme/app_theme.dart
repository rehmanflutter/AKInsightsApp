import 'package:flutter/material.dart';

/// Central place for the app's "pro" gradient color system.
/// Deep purple -> magenta -> orange (Instagram-inspired) plus
/// a dark glass background system.
class AppColors {
  AppColors._();

  static const Color bgDark = Color(0xFF0B0B14);
  static const Color bgDark2 = Color(0xFF121224);
  static const Color surface = Color(0xFF181830);
  static const Color surfaceLight = Color(0xFF20203F);

  static const Color purple = Color(0xFF8338EC);
  static const Color violet = Color(0xFF6A11CB);
  static const Color magenta = Color(0xFFE5249F);
  static const Color pink = Color(0xFFFF2D78);
  static const Color orange = Color(0xFFFF8A3D);
  static const Color blue = Color(0xFF2D9CFF);
  static const Color green = Color(0xFF2BDB8F);
  static const Color red = Color(0xFFFF4D6D);

  static const Color textPrimary = Color(0xFFF5F4FF);
  static const Color textSecondary = Color(0xFFA8A6C2);
  static const Color textFaint = Color(0xFF6E6C8C);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [violet, magenta, orange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purplePinkGradient = LinearGradient(
    colors: [purple, pink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF2D9CFF), Color(0xFF7C4DFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF2BDB8F), Color(0xFF12B886)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient redGradient = LinearGradient(
    colors: [Color(0xFFFF4D6D), Color(0xFFC9184A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [bgDark, bgDark2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgDark,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.dark(
        primary: AppColors.purple,
        secondary: AppColors.magenta,
        surface: AppColors.surface,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          fontSize: 28,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 15),
        bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        bodySmall: TextStyle(color: AppColors.textFaint, fontSize: 11),
      ),
    );
  }
}
