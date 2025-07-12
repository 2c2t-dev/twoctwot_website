import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Couleurs principales - Conservation de la DA 2c2t avec améliorations de lisibilité
  static const Color primaryColor = Color(0xFF081FF7);     // Bleu électrique 2c2t conservé
  static const Color primaryLight = Color(0xFF3B4EF8);     // Version plus claire du bleu 2c2t
  static const Color secondaryColor = Color(0xFF06B6D4);   // Cyan complémentaire amélioré
  static const Color backgroundColor = Color(0xFF0F0F0F);  // Noir moins profond pour meilleur contraste
  static const Color surfaceColor = Color(0xFF1A1A1A);    // Surface équilibrée
  static const Color cardColor = Color(0xFF151515);       // Cards avec bon contraste
  static const Color textPrimary = Color(0xFFE5E7EB);     // Texte principal blanc cassé
  static const Color textSecondary = Color(0xFFD1D5DB);   // Texte secondaire lisible
  static const Color textMuted = Color(0xFF9CA3AF);       // Texte atténué
  static const Color borderColor = Color(0xFF374151);     // Bordures visibles
  static const Color borderLight = Color(0xFF4B5563);     // Bordures claires
  
  // Couleurs d'accent en harmonie avec le bleu 2c2t
  static const Color accentBlue = Color(0xFF2563EB);      // Bleu d'accent lisible
  static const Color accentCyan = Color(0xFF22D3EE);      // Cyan d'accent
  static const Color successColor = Color(0xFF10B981);    // Vert succès
  static const Color warningColor = Color(0xFFF59E0B);    // Orange warning
  static const Color errorColor = Color(0xFFEF4444);      // Rouge erreur

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
        outline: borderColor,
        outlineVariant: borderLight,
      ),

      // Typography - avec fallbacks robustes
      textTheme: _buildTextTheme(),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: primaryColor, // Utilisation du bleu 2c2t
        elevation: 0,
        titleTextStyle: GoogleFonts.museoModerno(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor, // Bleu 2c2t pour le titre
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
          foregroundColor: Colors.white,
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
        color: primaryColor, // Bleu 2c2t pour les sous-titres importants
      ),
      titleLarge: GoogleFonts.museoModerno(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: primaryColor, // Bleu 2c2t pour les titres
      ),
      titleMedium: GoogleFonts.museoModerno(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: primaryLight, // Version plus claire du bleu 2c2t
      ),
      titleSmall: GoogleFonts.museoModerno(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textSecondary,
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
      bodySmall: GoogleFonts.jetBrainsMono(
        fontSize: 12,
        color: textMuted,
        height: 1.4,
      ),
      labelLarge: GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      labelMedium: GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
      labelSmall: GoogleFonts.jetBrainsMono(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textMuted,
      ),
    );
  }

  // Méthodes utilitaires pour la palette 2c2t
  static Color get primary2c2tWithOpacity => primaryColor.withValues(alpha: 0.8);
  static Color get primary2c2tBackground => primaryColor.withValues(alpha: 0.1);
  static Color get primary2c2tBorder => primaryColor.withValues(alpha: 0.3);
  
  // Gradients signature 2c2t
  static LinearGradient get primary2c2tGradient => LinearGradient(
    colors: [
      primaryColor.withValues(alpha: 0.8),
      primaryLight.withValues(alpha: 0.6),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get surface2c2tGradient => LinearGradient(
    colors: [
      primaryColor.withValues(alpha: 0.15),
      primaryColor.withValues(alpha: 0.05),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// Extensions pour les couleurs customisées avec DA 2c2t
extension AppColors on ColorScheme {
  Color get matrix => const Color(0xFF10B981);        // Vert matrix lisible
  Color get cyan => AppTheme.secondaryColor;          // Cyan complémentaire
  Color get darkSurface => AppTheme.cardColor;        // Surface sombre
  Color get border => AppTheme.borderColor;           // Bordures
  Color get borderLight => AppTheme.borderLight;      // Bordures claires
  Color get textMuted => AppTheme.textMuted;          // Texte atténué
  Color get success => AppTheme.successColor;         // Succès
  Color get warning => AppTheme.warningColor;         // Warning
  Color get error => AppTheme.errorColor;             // Erreur
  
  // Variations du bleu 2c2t pour la hiérarchie
  Color get primary2c2t => AppTheme.primaryColor;     // Bleu 2c2t original
  Color get primary2c2tLight => AppTheme.primaryLight; // Version claire
  Color get primary2c2tDark => const Color(0xFF051399); // Version foncée
}
