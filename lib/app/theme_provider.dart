import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', themeMode.toString());
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode');
    if (themeString != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == themeString,
        orElse: () => ThemeMode.system,
      );
      notifyListeners();
    }
  }
}
