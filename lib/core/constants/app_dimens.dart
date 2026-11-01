/// All dimension/spacing constants used across the app.
/// Base design frame width: 414 logical px.
library;

class AppDimens {
  AppDimens._();

  // Layout
  static const double horizontalMargin = 20.0;
  static const double designFrameWidth = 414.0;

  // Title (Screen 1)
  static const double titleTopOffset = 43.0;
  static const double titleFontSize = 20.0;
  static const double titleLineHeight = 1.2; // 24/20
  static const double titleLetterSpacing = 0.0;

  // Card (shared)
  static const double cardTopOffset = 80.0;
  /// Actual gap rendered between the title and the card top edge (Screen 1).
  static const double titleToCardGap = 12.0;
  static const double cardBorderRadius = 20.0;
  static const double cardBorderWidth = 1.0;
  static const double cardShadowBlur = 4.0;
  static const double cardShadowOffsetY = 1.0;
  static const double cardVerticalPadding = 16.0;

  // Language tile (Screen 1)
  static const double tileRowPitch = 64.0;
  static const double tileContentHeight = 41.0;
  static const double tileTextStartX = 45.0;
  static const double tileNameFontSize = 14.0;
  static const double tileGreetingFontSize = 12.0;
  static const double tileVerticalPadding = 7.0;

  // Radio indicator (Screen 1)
  static const double radioSize = 16.0;
  static const double radioBorderWidth = 1.0;
  static const double radioDotSize = 8.0;

  // Button (shared)
  static const double buttonHeight = 50.0;
  static const double buttonBorderRadius = 10.0;
  static const double buttonFontSize = 15.0;
  static const double buttonBottomMinClearance = 24.0;
  static const double cardButtonGap = 25.0;

  // ── Screen 2 – Register ────────────────────────────────────────────
  static const double logoWidth = 150.0;
  static const double logoTopGap = 24.0;       // below safe-area top
  static const double logoToCardGap = 20.0;

  // Auth card inner padding
  static const double authCardHPadding = 24.0;
  static const double authCardVPadding = 24.0;

  // Register form
  static const double cardTitleFontSize = 24.0;
  static const double cardSubtitleFontSize = 12.0;
  static const double titleSubtitleGap = 6.0;
  static const double subtitleToFieldsGap = 28.0;
  static const double fieldHeight = 48.0;
  static const double fieldBorderRadius = 10.0;
  static const double fieldBorderWidth = 1.0;
  static const double fieldHPadding = 16.0;
  static const double fieldFontSize = 14.0;
  static const double fieldIconSize = 18.0;
  static const double fieldGap = 14.0;
  static const double fieldsToTermsGap = 12.0;
  static const double checkboxSize = 16.0;
  static const double checkboxRadius = 3.0;
  static const double checkboxBorderWidth = 1.0;
  static const double termsToSignInGap = 16.0;
  static const double signInToButtonGap = 20.0;
}
