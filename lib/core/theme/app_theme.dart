import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF282748);
  static const accent = Color(0xFFF6C042);
  static const primary = Color(0xFFF5F5F5);

  static const secondary = Color(0xFF4E4B7C);
  static const secondaryAccent = Color(0xFFCACADB);
}

class AppTheme {
  AppTheme();

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      );
}
