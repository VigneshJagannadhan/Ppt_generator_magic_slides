import 'package:flutter/material.dart';
import 'package:indian_app_guy/shared/providers/base_provider.dart';

class ThemeProvider extends BaseProvider {
  @override
  reset() {
    _themeMode = ThemeMode.system;
  }

  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;
  set themeMode(value) {
    _themeMode = value;
    notifyListeners();
  }

  setDarkTheme(value) {
    if (value) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
