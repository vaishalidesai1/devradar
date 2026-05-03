import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background    = Color(0xFFFFF8F0);
  static const Color surface       = Color(0xFFFFFFFF);
  static const Color surfaceAlt    = Color(0xFFFFF0E6);
  static const Color cardBg        = Color(0xFFFFFFFF);
  static const Color primary       = Color(0xFFFF6B6B);
  static const Color primaryLight  = Color(0xFFFFAFA0);
  static const Color secondary     = Color(0xFF4ECDC4);
  static const Color secondaryLight= Color(0xFFB2EBE7);
  static const Color accent        = Color(0xFFFFBE0B);
  static const Color accentLight   = Color(0xFFFFE580);
  static const Color purple        = Color(0xFFA78BFA);
  static const Color purpleLight   = Color(0xFFEDE9FE);
  static const Color textPrimary   = Color(0xFF2D2A26);
  static const Color textSecondary = Color(0xFF8A7E72);
  static const Color textMuted     = Color(0xFFBAAFA6);
  static const Color textOnDark    = Color(0xFFFFFFFF);

  static const Map<String, Color> languageColors = {
    'Dart':       Color(0xFF00B4D8),
    'Flutter':    Color(0xFF54C5F8),
    'Python':     Color(0xFF4ECDC4),
    'JavaScript': Color(0xFFFFBE0B),
    'TypeScript': Color(0xFF4A90D9),
    'Rust':       Color(0xFFFF6B6B),
    'Go':         Color(0xFF00ADD8),
    'Swift':      Color(0xFFFF6B35),
    'Kotlin':     Color(0xFFA78BFA),
    'Java':       Color(0xFFFF8C42),
    'C++':        Color(0xFF6C91BF),
    'Unknown':    Color(0xFFBAAFA6),
  };

  static Color forLanguage(String lang) =>
      languageColors[lang] ?? languageColors['Unknown']!;
}

class AppTheme {
  static ThemeData get light {
    final base = GoogleFonts.nunitoTextTheme().copyWith(
      displayLarge: GoogleFonts.nunito(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.textPrimary, letterSpacing: -1),
      headlineLarge: GoogleFonts.nunito(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: -0.5),
      headlineMedium: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
      titleLarge: GoogleFonts.nunito(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      titleMedium: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      bodyLarge: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textPrimary, height: 1.5),
      bodyMedium: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textSecondary, height: 1.4),
      labelLarge: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      labelSmall: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted, letterSpacing: 0.5),
    );

    return ThemeData(
      useMaterial3: true,
      textTheme: base,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 22, fontWeight: FontWeight.w800,
          color: AppColors.textPrimary, letterSpacing: -0.5,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFF0E6DC), width: 1.5),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceAlt,
        labelStyle: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700),
        unselectedLabelStyle: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w500),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceAlt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintStyle: GoogleFonts.nunito(color: AppColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
    );
  }
}
