/// All dimension/spacing constants used across the app.
library;

class AppDimens {
  AppDimens._();

  // Screen 1 – Language & shared button
  static const double horizontalMargin = 20.0, designFrameWidth = 414.0;
  static const double titleTopOffset = 43.0, titleFontSize = 20.0, titleLineHeight = 1.2, titleToCardGap = 12.0;
  static const double cardTopOffset = 80.0, cardBorderRadius = 20.0, cardBorderWidth = 1.0, cardVerticalPadding = 16.0;
  static const double cardShadowBlur = 4.0, cardShadowOffsetY = 1.0, tileRowPitch = 64.0, tileContentHeight = 41.0;
  static const double tileTextStartX = 45.0, tileNameFontSize = 14.0, tileGreetingFontSize = 12.0, tileVerticalPadding = 7.0;
  static const double radioSize = 16.0, radioBorderWidth = 1.0, radioDotSize = 8.0, buttonHeight = 50.0;
  static const double buttonBorderRadius = 10.0, buttonFontSize = 15.0, buttonBottomMinClearance = 24.0, cardButtonGap = 25.0;

  // Screen 2 & 3 – Register & OTP
  static const double logoWidth = 150.0, logoTopGap = 24.0, logoToCardGap = 20.0;
  static const double authCardHPadding = 24.0, authCardVPadding = 24.0;
  static const double cardTitleFontSize = 24.0, cardSubtitleFontSize = 12.0;
  static const double titleSubtitleGap = 6.0, subtitleToFieldsGap = 28.0;
  static const double fieldHeight = 48.0, fieldBorderRadius = 10.0;
  static const double fieldBorderWidth = 1.0, fieldHPadding = 16.0;
  static const double fieldFontSize = 14.0, fieldIconSize = 18.0, fieldGap = 14.0;
  static const double fieldsToTermsGap = 12.0, checkboxSize = 16.0;
  static const double checkboxRadius = 3.0, checkboxBorderWidth = 1.0;
  static const double termsToSignInGap = 16.0, otpTitleFontSize = 26.0;
  static const double otpTitleLineHeight = 1.2, otpDescFontSize = 13.0;
  static const double otpTitleToDescGap = 14.0, otpDescToInputGap = 28.0;
  static const double otpBoxSize = 46.0, otpBoxRadius = 8.0;
  static const double otpBoxBorderWidth = 1.0, otpBoxFocusedBorderWidth = 1.5;
  static const double otpBoxGap = 10.0, otpDigitFontSize = 18.0;
  static const double otpInputToPhoneGap = 20.0, otpPhoneFontSize = 13.0;
  static const double otpCardPadding = 20.0, otpPhoneToResendGap = 24.0;

  // Screen 4 – Sign In
  static const double signInTitleFontSize = 26.0, signInSubtitleFontSize = 13.0;
  static const double signInTitleSubtitleGap = 8.0, forgotPasswordTopGap = 8.0;
  static const double forgotPasswordFontSize = 13.0, authPromptFontSize = 13.0;
  static const double signInToSignUpGap = 20.0;

  // Screen 5 – Home & Shared Calling Bar
  static const double homePageHorizontalMargin = 8.0, homeTopMargin = 8.0;
  static const double homeHeaderHeight = 85.0, homeHeaderRadius = 16.0;
  static const double homeHeaderPadding = 16.0, homeAvatarSize = 48.0;
  static const double homeAvatarToTextGap = 12.0, homeGreetingFontSize = 12.0;
  static const double homeTitleFontSize = 16.0, homeHeaderToInfoGap = 16.0;
  static const double homeInfoCardRadius = 16.0, homeInfoTextFontSize = 13.0;
  static const double homeInfoTextLineHeight = 1.5, homeInfoTextToVideoGap = 12.0;
  static const double homeVideoBorderRadius = 16.0, homeVideoBorderWidth = 1.0;
  static const double homeBottomBarBottomClearance = 18.0, homeBottomBarMargin = 12.0;
  static const double whatsappButtonSize = 44.0, whatsappButtonRadius = 8.0;
  static const double whatsappButtonBorderWidth = 1.5, whatsappIconSize = 26.0;
  static const double whatsappToStartCallingGap = 10.0;
  static const double startCallingButtonHeight = 46.0, startCallingButtonRadius = 8.0;
  static const double startCallingButtonFontSize = 15.0;

  // Dashboard & Navigation
  static const double dashboardFrameW = 367.0, dashboardFrameH = 729.0;
  static const double dashboardAppBarHeight = 56.0, dashboardMenuIconSize = 26.0;
  static const double dashboardActionIconSize = 24.0, dashboardActionGap = 14.0;
  static const double dashboardActionRightMargin = 12.0, dashboardCardMargin = 10.0;
  static const double dashboardHeaderRadius = 16.0, dashboardHeaderToCardGap = 16.0;
  static const double loadNumberCardRadius = 20.0, loadNumberNavyHeight = 48.0;
  static const double loadNumberLetterSpacing = 0.3, loadNumberImageHeight = 210.0;
  static const double loadNumberHPadding = 16.0, loadNumberTextToImageGap = 12.0;
  static const double dashboardBottomNavHeight = 72.0, bottomNavTopRadius = 24.0;
  static const double bottomNavPillWidth = 72.0, bottomNavPillHeight = 42.0;
  static const double bottomNavPillRadius = 21.0, bottomNavIconSize = 24.0;

  // Settings & Calling Lists
  static const double settingsBaseWidth = 376.0, settingsBackIconSize = 18.0;
  static const double profileSummaryHeight = 152.0, profileSummaryRadius = 20.0;
  static const double profileSummaryMargin = 16.0, profileSummaryPadding = 16.0;
  static const double profileSummaryLineGap = 6.0, profileSettingsBandHeight = 44.0;
  static const double settingsRowHeight = 64.0, settingsRowGap = 18.0;
  static const double iconBoxSize = 36.0, iconBoxRadius = 10.0;
  static const double arrowBoxSize = 24.0, arrowBoxRadius = 6.0, arrowBoxBorderWidth = 1.5;
  static const double callingListTileRadius = 12.0, callingListTileHeight = 64.0;
  static const double callingListTileGap = 14.0, callingListTilePadding = 16.0;
  static const double refreshButtonRadius = 8.0, refreshButtonHeight = 32.0;
  static const double refreshButtonHPadding = 10.0, refreshIconSize = 16.0;

  // Dashboard Selected List & Drawer
  static const double selectedListMargin = 14.0, selectedListHeight = 98.0;
  static const double selectedListRadius = 16.0, selectedListAvatarSize = 64.0;
  static const double donutDiameter = 205.0, donutRingThickness = 32.0;
  static const double statTileHeight = 80.0, statTileRadius = 16.0;
  static const double statTilePadding = 12.0, statTileBarWidth = 4.0, statTileBarHeight = 34.0;
  static const double statsRowGap = 9.0;
  static const double drawerWidthFactor = 0.73, drawerRadius = 20.0;
  static const double drawerHeaderHeight = 72.0, drawerHeaderPadding = 12.0;
  static const double drawerAvatarSize = 40.0, drawerAvatarGap = 12.0;
  static const double drawerPillWidth = 42.0, drawerPillHeight = 30.0, drawerPillRadius = 15.0;
  static const double drawerRowHeight = 45.0, drawerIconSize = 20.0;
}
