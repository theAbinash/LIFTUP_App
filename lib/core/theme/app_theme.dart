
import 'package:flutter/material.dart';

@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  final Color card;
  final Color border;
  final Color textSecondary;

  const AppTheme({
    required this.card,
    required this.border,
    required this.textSecondary,
  });

  @override
  AppTheme copyWith({
    Color? card,
    Color? border,
    Color? textSecondary,
  }) {
    return AppTheme(
      card: card ?? this.card,
      border: border ?? this.border,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  AppTheme lerp(
    ThemeExtension<AppTheme>? other,
    double t,
  ) {
    if (other is! AppTheme) return this;

    return AppTheme(
      card: Color.lerp(card, other.card, t)!,
      border: Color.lerp(border, other.border, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}

 /* final colors = Theme.of(context).extension<AppThemeColors>()!;

final colors = Theme.of(context).extension<AppThemeColors>()!;

Container(
  color: colors.card,
) */