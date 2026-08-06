
import 'package:flutter/material.dart';
import 'package:liftup/core/theme/app_colors.dart';
import 'package:liftup/core/theme/app_radius.dart';
import 'package:liftup/core/theme/app_text_styles.dart';

@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  final Color card;
  final Color border;
  final Color textSecondary;

  /* final Color success;
  final Color warning;
  final Color error; */

  const AppTheme({
    required this.card,
    required this.border,
    required this.textSecondary,
    /* required this.success,
    required this.warning,
    required this.error, */
  });

  @override
  AppTheme copyWith({
    Color? card,
    Color? border,
    Color? textSecondary,
    /* Color? success,
    Color? warning,
    Color? error, */
  }) {
    return AppTheme(
      card: card ?? this.card,
      border: border ?? this.border,
      textSecondary: textSecondary ?? this.textSecondary,
      /* success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error, */
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;
    return AppTheme(
      card: Color.lerp(card, other.card, t)!,
      border: Color.lerp(border, other.border, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      /* success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!, */
    );
  }

  // ---- LIGHT THEME ----
  static ThemeData get lightTheme {
    const ext = AppTheme(
      card: AppColors.lightCard,
      border: AppColors.lightBorder,
      textSecondary: Colors.black54,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      cardColor: AppColors.lightCard,
      dividerColor: AppColors.lightBorder,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.lightSurface,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.lightBackground,
        foregroundColor: Colors.black,
      ),
      textTheme: _textTheme(Colors.black, Colors.black54),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: const UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ext.border),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        hintStyle: TextStyle(
          color: ext.textSecondary,
        ),
      ),
      extensions: const [ext],
    );
  }

  // ---- DARK THEME ----
  static ThemeData get darkTheme {
    const ext = AppTheme(
      card: AppColors.darkCard,
      border: AppColors.darkBorder,
      textSecondary: Colors.white70,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      cardColor: AppColors.darkCard,
      dividerColor: AppColors.darkBorder,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.darkSurface,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.darkBackground,
        foregroundColor: Colors.white,
      ),
      textTheme: _textTheme(Colors.white, Colors.white70),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: const UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ext.border),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        hintStyle: TextStyle(
          color: ext.textSecondary,
        ),
      ),
      extensions: const [ext],
    );
  }

  static TextTheme _textTheme(Color primaryColor, Color secondaryColor) {
    return TextTheme(
      headlineLarge: AppTextStyles.heading1.copyWith(color: primaryColor),
      headlineMedium: AppTextStyles.heading2.copyWith(color: primaryColor),
      titleLarge: AppTextStyles.title.copyWith(color: primaryColor),
      bodyLarge: AppTextStyles.body.copyWith(color: primaryColor),
      labelLarge: AppTextStyles.label.copyWith(color: primaryColor),
      bodySmall: AppTextStyles.caption.copyWith(color: secondaryColor),
    );
  }

}