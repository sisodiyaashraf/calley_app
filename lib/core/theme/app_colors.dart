import 'package:flutter/material.dart';

/// Centralised colour palette for the Calley app.
class AppColors {
  AppColors._();

  // Brand & Page
  static const Color primary = Color(0xFF2563EB), link = Color(0xFF2563EB);
  static const Color pageBackground = Color(0xFFF8FAFC);

  // Title & Text
  static const Color titleText = Color(0xFF000000), subtitleText = Color(0xFF64748B);
  static const Color buttonText = Color(0xFFFFFFFF), whiteText = Color(0xFFFFFFFF);
  static const Color whiteText85 = Color(0xD9FFFFFF), dashboardText = Color(0xFF0F172A);

  // Card (Screens 1, 2, 3, 4)
  static const Color cardBackground = Color(0xFFFFFFFF), cardBorder = Color(0xFFCBD5E1);
  static const Color cardShadow = Color(0x0A0F172A);

  // Tile & Radio (Screen 1)
  static const Color tileNameText = Color(0xFF000000), tileGreetingText = Color(0xFF64748B);
  static const Color radioBorder = Color(0xFF000000), radioDot = Color(0xFF000000);

  // Form (Screens 2, 3, 4)
  static const Color fieldText = Color(0xFF000000), fieldHint = Color(0xFF94A3B8);
  static const Color fieldBorder = Color(0xFFCBD5E1), fieldIcon = Color(0xFF000000);
  static const Color errorText = Color(0xFFDC2626), checkboxBorder = Color(0xFFCBD5E1);
  static const Color checkboxChecked = Color(0xFF2563EB);

  // Home & Dashboard & Settings
  static const Color navyCardBackground = Color(0xFF1E3A8A);
  static const Color whatsappBorder = Color(0xFF22C55E), headerCardShadow = Color(0x1A2563EB);
  static const Color bottomNavBackground = Color(0xFFEFF6FF), bottomNavInactive = Color(0xFF0F172A);

  // Donut Chart & Stat Tiles
  static const Color donutDone = Color(0xFF1F74EC), donutScheduled = Color(0xFF9566F2);
  static const Color donutPending = Color(0xFFFAAB3C), donutHole = Color(0xFFF4F5F7);
  static const Color statPendingBg = Color(0xFFFEF0DB), statPendingBar = Color(0xFFFAAB3C);
  static const Color statDoneBg = Color(0xFFDDFCE0), statDoneBar = Color(0xFF0EB01D);
  static const Color statScheduleBg = Color(0xFFF3EEFE), statScheduleBar = Color(0xFF4E1BD9);

  // Side Navigation Drawer
  static const Color drawerBackground = Color(0xFFEFF6FF);
  static const Color drawerPlanAmber = Color(0xFFF5B342);
  static const Color drawerDivider = Color(0xFFCBD5E1);
  static const Color drawerScrim = Color(0x80000000);
}
