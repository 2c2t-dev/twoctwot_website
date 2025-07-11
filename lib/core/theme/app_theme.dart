import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Couleurs principales - DA 2c2t
  static const Color primaryColor = Color(0xFF081FF7);  // Bleu électrique 2c2t
  static const Color secondaryColor = Color(0xFF00DDFF); // Cyan complémentaire
  static const Color backgroundColor = Color(0xFF0A0A0A); // Noir profond
  static const Color surfaceColor = Color(0xFF1A1A1A);   // Gris foncé
  static const Color cardColor = Color(0xFF111111);      // Cards
  static const Color textPrimary = Color(0xFF081FF7);    // Texte principal bleu
  static const Color textSecondary = Color(0xFFB0B0B0);  // Texte secondaire
  static const Color borderColor = Color(0xFF333333);    // Bordures

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        onSurface: textPrimary,
        onPrimary: backgroundColor,
        onSecondary: backgroundColor,
      ),

      // Typography - avec fallbacks robustes
      textTheme: _buildTextTheme(),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textPrimary,
        elevation: 0,
        titleTextStyle: GoogleFonts.museoModerno(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }

  // Méthode pour construire le thème de texte avec Google Fonts
  static TextTheme _buildTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.museoModerno(
        fontSize: 56,
        fontWeight: FontWeight.bold,
        color: textPrimary,
        letterSpacing: -1.5,
      ),
      displayMedium: GoogleFonts.museoModerno(
        fontSize: 44,
        fontWeight: FontWeight.bold,
        color: textPrimary,
        letterSpacing: -1.0,
      ),
      displaySmall: GoogleFonts.museoModerno(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: textPrimary,
        letterSpacing: -0.5,
      ),
      headlineLarge: GoogleFonts.museoModerno(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: textPrimary,
        letterSpacing: -1.5,
      ),
      headlineMedium: GoogleFonts.museoModerno(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: -0.5,
      ),
      headlineSmall: GoogleFonts.museoModerno(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: GoogleFonts.museoModerno(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.museoModerno(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      titleSmall: GoogleFonts.museoModerno(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      bodyLarge: GoogleFonts.jetBrainsMono(
        fontSize: 16,
        color: textSecondary,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.jetBrainsMono(
        fontSize: 14,
        color: textSecondary,
        height: 1.5,
      ),
    );
  }
}

// Extensions pour les couleurs customisées
extension AppColors on ColorScheme {
  Color get matrix => const Color(0xFF00FF88);
  Color get cyan => const Color(0xFF00DDFF);
  Color get darkSurface => const Color(0xFF111111);
  Color get border => const Color(0xFF333333);
}
