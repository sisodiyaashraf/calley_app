/// All dimension/spacing constants used across the app.
/// Base design frame width: 414 logical px.
library;

class AppDimens {
  AppDimens._();

  // Layout
  static const double horizontalMargin = 20.0;
  static const double designFrameWidth = 414.0;

  // Title
  static const double titleTopOffset = 43.0;
  static const double titleFontSize = 20.0;
  static const double titleLineHeight = 1.2; // 24/20
  static const double titleLetterSpacing = 0.0;

  // Card
  static const double cardTopOffset = 80.0;
  /// Actual gap rendered between the title and the card top edge.
  static const double titleToCardGap = 12.0;
  static const double cardBorderRadius = 20.0;
  static const double cardBorderWidth = 1.0;
  static const double cardShadowBlur = 4.0;
  static const double cardShadowOffsetY = 1.0;
  static const double cardVerticalPadding = 16.0;

  // Language tile
  static const double tileRowPitch = 64.0;
  static const double tileContentHeight = 41.0;
  static const double tileTextStartX = 45.0; // from card left edge
  static const double tileNameFontSize = 14.0;
  static const double tileGreetingFontSize = 12.0;
  static const double tileVerticalPadding = 7.0;

  // Radio indicator
  static const double radioSize = 16.0;
  static const double radioBorderWidth = 1.0;
  static const double radioDotSize = 8.0;

  // Button
  static const double buttonHeight = 50.0;
  static const double buttonBorderRadius = 10.0;
  static const double buttonFontSize = 15.0;
  static const double buttonBottomMinClearance = 24.0;
  static const double cardButtonGap = 25.0;
}
