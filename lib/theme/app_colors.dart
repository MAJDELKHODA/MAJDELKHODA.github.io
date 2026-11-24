import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Soft luxury palette: warm white + powder pink + burgundy.
class AppColors {
  AppColors._();

  static const background = Color(0xFFFFFBFA); // warm white
  static const backgroundAlt = Color(0xFFFCF1F0); // blush
  static const surface = Color(0xFFFFFFFF);
  static const surfaceLight = Color(0xFFFFF7F6);
  static const gold = Color(0xFF7A2E3B); // burgundy (main accent)
  static const goldLight = Color(0xFFB4586A); // rose
  static const goldDark = Color(0xFF5A1F2A);
  static const powder = Color(0xFFE8C4C4); // powder pink
  static const text = Color(0xFF2A1A1E);
  static const textMuted = Color(0xFF7D6A6E);
  static const border = Color(0xFFF0DEDD);
  static const shadow = Color(0x1F7A2E3B);
  static const success = Color(0xFF3FAE6A);

  // Kept for older widgets that still reference these names.
  static const primary = gold;
  static const accent = gold;

  static const goldGradient = LinearGradient(
    colors: [Color(0xFF9B3D4C), gold, goldDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// Typography: elegant serif for headings, clean sans for body.
class AppText {
  AppText._();

  static TextStyle display(double size, {Color color = AppColors.text, FontWeight weight = FontWeight.w600, double height = 1.15}) =>
      GoogleFonts.playfairDisplay(fontSize: size, fontWeight: weight, color: color, height: height);

  static TextStyle body(double size, {Color color = AppColors.text, FontWeight weight = FontWeight.w400, double height = 1.6, double letterSpacing = 0}) =>
      GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color, height: height, letterSpacing: letterSpacing);
}
