// lib/theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPurple = Color(0xFF52006A);
  static const Color accentRed     = Color(0xFFCD113B);
  static const Color accentOrange  = Color(0xFFFF7600);
  static const Color cardBackground= Color(0xFFFFEDE0);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryPurple,
    scaffoldBackgroundColor: primaryPurple,
    fontFamily: 'Montserrat',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}

