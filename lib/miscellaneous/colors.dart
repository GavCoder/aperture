import 'package:flutter/material.dart';

/// Application color constants for consistent theming across the app
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Gradient Colors
  static const Color gradientPurple = Color(0xFF6B4C9A);
  static const Color gradientMediumPurple = Color(0xFF8B6BA8);
  static const Color gradientRed = Color(0xFFA85C5C);
  static const Color gradientOrange = Color(0xFFD45C4C);

  // Scaffold Background Color
  static const Color scaffoldBackground = Color(0xFF121212);

  // Gradient List for reuse
  static const List<Color> appGradient = [
    gradientPurple,
    gradientMediumPurple,
    gradientRed,
    gradientOrange,
  ];

  // Icon Colors
  static const Color iconWhite = Colors.white;
  static const Color iconDarkGrey = Color(0xFF1F2937);

  // Logo Gradient Colors
  static const Color logoPurple = Color(0xFFB794F6);
  static const Color logoBlue = Color(0xFF60A5FA);

  // Text Colors
  static const Color textWhite = Colors.white;
  static const Color textDarkGrey = Color(0xFF1F2937);

  // Transparent/Overlay Colors
  static const Color overlayDark = Color(0xFF000000);
  static const Color overlayLight = Colors.white;

  // Helper function to get white with opacity
  static Color whiteWithOpacity(double opacity) =>
      Colors.white.withOpacity(opacity);

  // Helper function to get black with opacity
  static Color blackWithOpacity(double opacity) =>
      Colors.black.withOpacity(opacity);

  // Button and Input Colors
  static Color inputFillColor = whiteWithOpacity(0.15);
  static Color inputBorderColor = whiteWithOpacity(0.3);
  static Color buttonBackgroundColor = whiteWithOpacity(0.2);
  static Color hintTextColor = whiteWithOpacity(0.6);
  static Color tabBackgroundColor = whiteWithOpacity(0.25);
  static Color tabBackgroundInactiveColor = blackWithOpacity(0.2);
}
