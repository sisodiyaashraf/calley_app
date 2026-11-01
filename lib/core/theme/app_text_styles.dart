import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../constants/app_dimens.dart';

/// Centralised text styles derived from Figma spec.
class AppTextStyles {
  AppTextStyles._();

  // Screen 1 – Language
  static TextStyle get screenTitle => GoogleFonts.inter(fontSize: AppDimens.titleFontSize, fontWeight: FontWeight.w500, height: AppDimens.titleLineHeight, color: AppColors.titleText);
  static TextStyle get tileName => GoogleFonts.inter(fontSize: AppDimens.tileNameFontSize, fontWeight: FontWeight.w500, color: AppColors.tileNameText);
  static TextStyle get tileGreeting => GoogleFonts.inter(fontSize: AppDimens.tileGreetingFontSize, fontWeight: FontWeight.w400, color: AppColors.tileGreetingText);
  static TextStyle get buttonLabel => GoogleFonts.inter(fontSize: AppDimens.buttonFontSize, fontWeight: FontWeight.w700, height: 1.0, color: AppColors.buttonText);

  // Screen 2 – Register
  static TextStyle get cardTitle => GoogleFonts.inter(fontSize: AppDimens.cardTitleFontSize, fontWeight: FontWeight.w600, color: AppColors.titleText);
  static TextStyle get cardSubtitle => GoogleFonts.inter(fontSize: AppDimens.cardSubtitleFontSize, fontWeight: FontWeight.w400, color: AppColors.subtitleText);
  static TextStyle get fieldText => GoogleFonts.inter(fontSize: AppDimens.fieldFontSize, fontWeight: FontWeight.w400, color: AppColors.fieldText);
  static TextStyle get fieldHint => GoogleFonts.inter(fontSize: AppDimens.fieldFontSize, fontWeight: FontWeight.w400, color: AppColors.fieldHint);
  static TextStyle get termsText => GoogleFonts.inter(fontSize: AppDimens.cardSubtitleFontSize, fontWeight: FontWeight.w400, color: AppColors.subtitleText);
  static TextStyle get termsLink => GoogleFonts.inter(fontSize: AppDimens.cardSubtitleFontSize, fontWeight: FontWeight.w400, color: AppColors.primary);

  // Screen 3 – OTP
  static TextStyle get otpTitle => GoogleFonts.inter(fontSize: AppDimens.otpTitleFontSize, fontWeight: FontWeight.w700, height: AppDimens.otpTitleLineHeight, color: AppColors.titleText);
  static TextStyle get otpDescription => GoogleFonts.inter(fontSize: AppDimens.otpDescFontSize, fontWeight: FontWeight.w400, color: AppColors.subtitleText);
  static TextStyle get otpDigit => GoogleFonts.inter(fontSize: AppDimens.otpDigitFontSize, fontWeight: FontWeight.w600, color: AppColors.fieldText);
  static TextStyle get otpPhone => GoogleFonts.inter(fontSize: AppDimens.otpPhoneFontSize, fontWeight: FontWeight.w500, color: AppColors.titleText);

  // Screen 4 – Sign In
  static TextStyle get signInTitle => GoogleFonts.inter(fontSize: AppDimens.signInTitleFontSize, fontWeight: FontWeight.w700, color: AppColors.titleText);
  static TextStyle get signInSubtitle => GoogleFonts.inter(fontSize: AppDimens.signInSubtitleFontSize, fontWeight: FontWeight.w400, color: AppColors.subtitleText);
  static TextStyle get forgotPassword => GoogleFonts.inter(fontSize: AppDimens.forgotPasswordFontSize, fontWeight: FontWeight.w500, color: AppColors.titleText);
  static TextStyle get authPrompt => GoogleFonts.inter(fontSize: AppDimens.authPromptFontSize, fontWeight: FontWeight.w400, color: AppColors.subtitleText);
  static TextStyle get authPromptLink => GoogleFonts.inter(fontSize: AppDimens.authPromptFontSize, fontWeight: FontWeight.w400, color: AppColors.primary);

  // Screen 5 & Dashboard
  static TextStyle get homeGreeting => GoogleFonts.inter(fontSize: AppDimens.homeGreetingFontSize, fontWeight: FontWeight.w400, color: AppColors.whiteText);
  static TextStyle get homeProfileTitle => GoogleFonts.inter(fontSize: AppDimens.homeTitleFontSize, fontWeight: FontWeight.w700, color: AppColors.whiteText);
  static TextStyle get homeInfoText => GoogleFonts.inter(fontSize: AppDimens.homeInfoTextFontSize, fontWeight: FontWeight.w400, height: AppDimens.homeInfoTextLineHeight, color: AppColors.whiteText);
  static TextStyle get startCallingButton => GoogleFonts.inter(fontSize: AppDimens.startCallingButtonFontSize, fontWeight: FontWeight.w600, color: AppColors.buttonText);
  static TextStyle get dashboardAppBarTitle => GoogleFonts.inter(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.dashboardText);
  static TextStyle get dashboardGreeting => GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.w400, color: AppColors.whiteText);
  static TextStyle get dashboardProfileTitle => GoogleFonts.inter(fontSize: 18.0, fontWeight: FontWeight.w700, color: AppColors.whiteText);
  static TextStyle get loadNumberHeader => GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w700, letterSpacing: AppDimens.loadNumberLetterSpacing, color: AppColors.whiteText);
  static TextStyle get richLinkBody => GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w400, height: 1.8, color: AppColors.titleText);
  static TextStyle get richLinkUrl => GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w400, height: 1.8, color: AppColors.link);
  static TextStyle get placeholderTitle => GoogleFonts.inter(fontSize: 20.0, fontWeight: FontWeight.w600, color: AppColors.dashboardText);

  // Settings & Calling Lists
  static TextStyle get settingsTitle => GoogleFonts.inter(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.dashboardText);
  static TextStyle get profileSummaryGreeting => GoogleFonts.inter(fontSize: 16.0, fontWeight: FontWeight.w700, color: AppColors.whiteText);
  static TextStyle get profileSummaryDetail => GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.w400, color: AppColors.whiteText85);
  static TextStyle get profileSettingsBand => GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.w700, color: AppColors.whiteText);
  static TextStyle get settingsRowLabel => GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.titleText);
  static TextStyle get callingListsBand => GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w700, color: AppColors.whiteText);
  static TextStyle get selectCallingListTitle => GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.titleText);
  static TextStyle get refreshButtonText => GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.w500, color: AppColors.whiteText);
  static TextStyle get callingListEmptyText => GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w400, color: AppColors.subtitleText);

  // Dashboard Selected List State
  static TextStyle get selectedListName => GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w600, height: 1.2, color: AppColors.titleText);
  static TextStyle get selectedListCount => GoogleFonts.inter(fontSize: 36.0, fontWeight: FontWeight.w700, height: 1.0, color: AppColors.primary);
  static TextStyle get selectedListCallsLabel => GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.w500, height: 1.0, color: AppColors.titleText);
  static TextStyle get selectedListAvatarLetter => GoogleFonts.inter(fontSize: 28.0, fontWeight: FontWeight.w600, height: 1.0, color: AppColors.whiteText);
  static TextStyle get statTileLabel => GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.w600, height: 1.1, color: AppColors.titleText);
  static TextStyle get statTileCount => GoogleFonts.inter(fontSize: 24.0, fontWeight: FontWeight.w700, height: 1.05, color: AppColors.titleText);
  static TextStyle get statTileSub => GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.w400, height: 1.1, color: AppColors.subtitleText);

  // Side Navigation Drawer
  static TextStyle get drawerHeaderName => GoogleFonts.inter(fontSize: 15.0, fontWeight: FontWeight.w700, color: AppColors.whiteText);
  static TextStyle get drawerHeaderPlan => GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.w600, color: AppColors.drawerPlanAmber);
  static TextStyle get drawerHeaderEmail => GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.w400, color: AppColors.whiteText);
  static TextStyle get drawerMenuItem => GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.w600, color: AppColors.dashboardText);
  static TextStyle get drawerSectionTitle => GoogleFonts.inter(fontSize: 15.0, fontWeight: FontWeight.w700, color: AppColors.primary);
}
