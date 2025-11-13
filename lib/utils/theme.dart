import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Warm Kitchen Colors - Light Mode
  static const Color warmCream = Color(0xFFFFF8E7);
  static const Color softBrown = Color(0xFF8B7355);
  static const Color mutedRed = Color(0xFFD4776C);
  static const Color darkBrown = Color(0xFF4A3C2F);
  static const Color accentGold = Color(0xFFE8B966);
  static const Color lightWood = Color(0xFFE5D4C1);

  // Dark Mode Colors
  static const Color darkSlate = Color(0xFF2A2D3A);
  static const Color darkSlateLight = Color(0xFF3A3D4A);
  static const Color amberHighlight = Color(0xFFFFB74D);
  static const Color elderberryPurple = Color(0xFF9575CD);
  static const Color darkWood = Color(0xFF4E4539);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: softBrown,
    scaffoldBackgroundColor: warmCream,
    cardColor: Colors.white,
    
    colorScheme: ColorScheme.light(
      primary: softBrown,
      secondary: mutedRed,
      tertiary: accentGold,
      surface: Colors.white,
      background: warmCream,
      error: mutedRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: darkBrown,
      onBackground: darkBrown,
    ),

    // Typography
    textTheme: TextTheme(
      displayLarge: GoogleFonts.merriweather(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: darkBrown,
      ),
      displayMedium: GoogleFonts.merriweather(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: darkBrown,
      ),
      displaySmall: GoogleFonts.merriweather(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: darkBrown,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkBrown,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: darkBrown,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: darkBrown,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        color: darkBrown,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        color: darkBrown,
      ),
      labelLarge: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: softBrown,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: softBrown,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: mutedRed,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightWood,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: softBrown, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: softBrown),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: amberHighlight,
    scaffoldBackgroundColor: darkSlate,
    cardColor: darkSlateLight,
    
    colorScheme: ColorScheme.dark(
      primary: amberHighlight,
      secondary: elderberryPurple,
      tertiary: amberHighlight,
      surface: darkSlateLight,
      background: darkSlate,
      error: mutedRed,
      onPrimary: darkSlate,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
    ),

    // Typography
    textTheme: TextTheme(
      displayLarge: GoogleFonts.merriweather(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.merriweather(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.merriweather(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        color: Colors.white70,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        color: Colors.white70,
      ),
      labelLarge: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: darkSlate,
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      elevation: 4,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: darkSlateLight,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: darkWood,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: amberHighlight,
        foregroundColor: darkSlate,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: elderberryPurple,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkWood,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: amberHighlight, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: amberHighlight),
  );
}
