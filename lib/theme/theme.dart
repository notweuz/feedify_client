import 'package:flutter/material.dart';

ThemeData _buildTheme(ColorScheme? dynamicScheme, ColorScheme defaultScheme) {
  ColorScheme colorScheme = dynamicScheme ?? defaultScheme;
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
  );
}

ThemeData getLightTheme(ColorScheme? dynamicColorScheme) {
  return _buildTheme(dynamicColorScheme, ColorScheme.light());
}

ThemeData getDarkTheme(ColorScheme? darkDynamicColorScheme) {
  return _buildTheme(darkDynamicColorScheme, ColorScheme.dark());
}
