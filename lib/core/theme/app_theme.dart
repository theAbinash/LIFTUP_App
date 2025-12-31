import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    dividerTheme: DividerThemeData(
      color: AppColors.lightDivider.withOpacity(0.4),
      thickness: 1,
      space: 16,
    ),
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      foregroundColor: AppColors.lightTextPrimary,
      backgroundColor: AppColors.lightAppBar,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.lightTextPrimary,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.lightHeading1,
      headlineLarge: AppTextStyles.lightHeading2,
      titleLarge: AppTextStyles.lightTitle,
      titleMedium: AppTextStyles.lightTitle,
      bodyLarge: AppTextStyles.lightBody,
      bodyMedium: AppTextStyles.lightBody,
      bodySmall: AppTextStyles.lightBodySmall,
      labelLarge: AppTextStyles.lightLabel,
      labelSmall: AppTextStyles.lightGrey,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.lightBackground,
      error: AppColors.error,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    dividerTheme: DividerThemeData(
      color: AppColors.darkDivider.withOpacity(0.4),
      thickness: 1,
      space: 16,
    ),
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      foregroundColor: AppColors.darkTextPrimary,
      backgroundColor: AppColors.darkAppBar,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.darkTextPrimary,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.darkHeading1,
      headlineLarge: AppTextStyles.darkHeading2,
      titleLarge: AppTextStyles.darkTitle,
      titleMedium: AppTextStyles.darkTitle,
      bodyLarge: AppTextStyles.darkBody,
      bodyMedium: AppTextStyles.darkBody,
      bodySmall: AppTextStyles.darkBodySmall,
      labelLarge: AppTextStyles.darkLabel,
      labelSmall: AppTextStyles.darkGrey,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.darkBackground,
      error: AppColors.error,
    ),
  );
}
