import 'package:flutter/material.dart';

class AppTheme {
  static const Color deepTeal = Color(0xFF2A7F85);
  static const Color warmOchre = Color(0xFFE8A243);
  static const Color softPageWhite = Color(0xFFFDFDFD);
  static const Color lightMistGrey = Color(0xFFF2F2F2);
  static const Color inkBlack = Color(0xFF2C2C2C);
  static const Color dustyGrey = Color(0xFF707070);
  static const Color lightAsh = Color(0xFFB0B0B0);
  static const Color successGreen = Color(0xFF27AE60);
  static const Color errorRed = Color(0xFFE74C3C);
  static const Color warningAmber = Color(0xFFF39C12);
  static const TextStyle totalAmountTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: inkBlack,
  );
  static const TextStyle sectionTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: inkBlack,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: softPageWhite,
    fontFamily: 'OpenSans',
    primaryColor: deepTeal,
    colorScheme: ColorScheme.light(
      primary: deepTeal,
      secondary: warmOchre,
      background: softPageWhite,
      surface: softPageWhite,
      onPrimary: softPageWhite,
      onSurface: inkBlack,
      error: errorRed,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: softPageWhite,
      elevation: 1,
      foregroundColor: inkBlack,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: inkBlack,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: inkBlack,
      ), // H1
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: inkBlack,
      ), // H2
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: inkBlack,
      ), // H3
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: inkBlack,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: dustyGrey,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: lightAsh,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: deepTeal,
      ), // Button
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: softPageWhite,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: lightMistGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: lightMistGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: deepTeal, width: 2),
      ),
      hintStyle: TextStyle(color: dustyGrey),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: deepTeal,
        foregroundColor: softPageWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: deepTeal,
        side: const BorderSide(color: deepTeal),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    dividerColor: lightMistGrey,
    iconTheme: const IconThemeData(color: dustyGrey),
  );
}
