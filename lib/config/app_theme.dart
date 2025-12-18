import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF0C455D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFF67E8F9);
  static const Color blue1 = Color(0xFF093243);
  static const Color blue2 = Color(0xFF2F718D);
  static const Color blue3 = Color(0xFFA9CBDB);
  static const Color blue4 = Color(0xFFF0F3F7);
  static const Color red = Color(0xFFF0A694);
}

class AppTheme {
  static final theme = ThemeData(
    textTheme: GoogleFonts.manropeTextTheme().copyWith(
      titleLarge: GoogleFonts.manrope(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.bold),
      bodyMedium: GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      toolbarHeight: 64,
      titleTextStyle: GoogleFonts.manrope(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),
    scaffoldBackgroundColor: AppColors.white,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
  );
}
