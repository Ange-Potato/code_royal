import 'package:flutter/material.dart';

final scheme = ColorScheme.dark(
  primary: const Color(0xFF0F4C5C),
  onPrimary: const Color(0xFFF1F5F9),
  secondary: const Color(0xFF8B1E3F),
  onSecondary: const Color(0xFFF1F5F9),
  surface: const Color(0xFF16313A),
  onSurface: const Color(0xFFF1F5F9),
  error: const Color(0xFFC1121F),
  onError: const Color(0xFFF1F5F9),
);

const textTheme = TextTheme(
  headlineSmall: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  ),
  bodyMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
  ),
  labelSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
);

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
}

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: scheme,
  scaffoldBackgroundColor: const Color(0xFF081C24),
  fontFamily: 'Silkscreen',
  textTheme: textTheme,
  cardTheme: const CardThemeData(
    margin: EdgeInsets.all(AppSpacing.sm),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(48),
    ),
  ),
);