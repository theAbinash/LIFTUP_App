import 'package:flutter/material.dart';
import 'package:liftup/core/theme/app_theme.dart';

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get text => theme.textTheme;
  AppTheme get app => theme.extension<AppTheme>()!;
}