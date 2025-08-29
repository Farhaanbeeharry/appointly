import 'package:flutter/material.dart';

class Brand {
  static const Color primary = Color(0xFF5B8CFF); // indigo
  static const Color secondary = Color(0xFF945CFF); // violet
  static const Color surface = Color(0xFFF7F8FA);

  static LinearGradient gradient() => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );
}

ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF070615),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Brand.surface,
    inputDecorationTheme: const InputDecorationTheme(
      filled: false,
      fillColor: Colors.transparent,
    ),
  );
}
