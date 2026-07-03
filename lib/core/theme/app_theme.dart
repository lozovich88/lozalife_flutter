import 'package:flutter/material.dart';

/// Material 3 theme configuration for the whole app.
abstract final class AppTheme {
  static const Color _seedColor = Color(0xFF3F51B5);

  static ThemeData get lightTheme => _build(Brightness.light);

  static ThemeData get darkTheme => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
      ),
      cardTheme: const CardThemeData(
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
