import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../constants/app_dimens.dart';

/// Centralised text styles derived from Figma spec.
class AppTextStyles {
  AppTextStyles._();

  // Screen 1
  static TextStyle get screenTitle => GoogleFonts.inter(
      fontSize: AppDimens.titleFontSize, fontWeight: FontWeight.w500,
      height: AppDimens.titleLineHeight, color: AppColors.titleText);
  static TextStyle get tileName => GoogleFonts.inter(
      fontSize: AppDimens.tileNameFontSize, fontWeight: FontWeight.w500, color: AppColors.tileNameText);
  static TextStyle get tileGreeting => GoogleFonts.inter(
      fontSize: AppDimens.tileGreetingFontSize, fontWeight: FontWeight.w400, color: AppColors.tileGreetingText);
  static TextStyle get buttonLabel => GoogleFonts.inter(
      fontSize: AppDimens.buttonFontSize, fontWeight: FontWeight.w700, height: 1.0, color: AppColors.buttonText);

  // Screen 2
  static TextStyle get cardTitle => GoogleFonts.inter(
      fontSize: AppDimens.cardTitleFontSize, fontWeight: FontWeight.w600, color: AppColors.titleText);
  static TextStyle get cardSubtitle => GoogleFonts.inter(
      fontSize: AppDimens.cardSubtitleFontSize, fontWeight: FontWeight.w400, color: AppColors.subtitleText);
  static TextStyle get fieldText => GoogleFonts.inter(
      fontSize: AppDimens.fieldFontSize, fontWeight: FontWeight.w400, color: AppColors.fieldText);
  static TextStyle get fieldHint => GoogleFonts.inter(
      fontSize: AppDimens.fieldFontSize, fontWeight: FontWeight.w400, color: AppColors.fieldHint);
  static TextStyle get termsText => GoogleFonts.inter(
      fontSize: AppDimens.cardSubtitleFontSize, fontWeight: FontWeight.w400, color: AppColors.subtitleText);
  static TextStyle get termsLink => GoogleFonts.inter(
      fontSize: AppDimens.cardSubtitleFontSize, fontWeight: FontWeight.w400, color: AppColors.primary);

  // Screen 3 – OTP
  static TextStyle get otpTitle => GoogleFonts.inter(
      fontSize: AppDimens.otpTitleFontSize, fontWeight: FontWeight.w700,
      height: AppDimens.otpTitleLineHeight, color: AppColors.titleText);
  static TextStyle get otpDescription => GoogleFonts.inter(
      fontSize: AppDimens.otpDescFontSize, fontWeight: FontWeight.w400, color: AppColors.subtitleText);
  static TextStyle get otpDigit => GoogleFonts.inter(
      fontSize: AppDimens.otpDigitFontSize, fontWeight: FontWeight.w600, color: AppColors.fieldText);
  static TextStyle get otpPhone => GoogleFonts.inter(
      fontSize: AppDimens.otpPhoneFontSize, fontWeight: FontWeight.w500, color: AppColors.titleText);

  // Screen 4 – Sign In
  static TextStyle get signInTitle => GoogleFonts.inter(
      fontSize: AppDimens.signInTitleFontSize, fontWeight: FontWeight.w700, color: AppColors.titleText);
  static TextStyle get signInSubtitle => GoogleFonts.inter(
      fontSize: AppDimens.signInSubtitleFontSize, fontWeight: FontWeight.w400, color: AppColors.subtitleText);
  static TextStyle get forgotPassword => GoogleFonts.inter(
      fontSize: AppDimens.forgotPasswordFontSize, fontWeight: FontWeight.w500, color: AppColors.titleText);
  static TextStyle get authPrompt => GoogleFonts.inter(
      fontSize: AppDimens.authPromptFontSize, fontWeight: FontWeight.w400, color: AppColors.subtitleText);
  static TextStyle get authPromptLink => GoogleFonts.inter(
      fontSize: AppDimens.authPromptFontSize, fontWeight: FontWeight.w400, color: AppColors.primary);
}
