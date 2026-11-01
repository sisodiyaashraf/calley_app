import 'package:flutter/material.dart';

/// Centralised colour palette for the Calley app.
/// All values taken directly from the Figma spec.
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF2563EB);

  // Page
  static const Color pageBackground = Color(0xFFF8FAFC);

  // Title
  static const Color titleText = Color(0xFF000000);

  // Card (Screen 1 & 2)
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFCBD5E1);
  static const Color cardShadow = Color(0x0A0F172A);

  // Tile (Screen 1)
  static const Color tileNameText = Color(0xFF000000);
  static const Color tileGreetingText = Color(0xFF64748B);

  // Radio (Screen 1)
  static const Color radioBorder = Color(0xFF000000);
  static const Color radioDot = Color(0xFF000000);

  // Button
  static const Color buttonText = Color(0xFFFFFFFF);

  // Form (Screen 2)
  static const Color fieldText = Color(0xFF000000);
  static const Color fieldHint = Color(0xFF94A3B8);
  static const Color fieldBorder = Color(0xFFCBD5E1);
  static const Color fieldIcon = Color(0xFF000000);
  static const Color subtitleText = Color(0xFF64748B);
  static const Color errorText = Color(0xFFDC2626);
  static const Color checkboxBorder = Color(0xFFCBD5E1);
  static const Color checkboxChecked = Color(0xFF2563EB);
}
