import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../constants/app_dimens.dart';

/// Centralised text styles derived from Figma spec.
/// All styles use Inter via google_fonts.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get screenTitle => GoogleFonts.inter(
        fontSize: AppDimens.titleFontSize,
        fontWeight: FontWeight.w500,
        height: AppDimens.titleLineHeight,
        letterSpacing: AppDimens.titleLetterSpacing,
        color: AppColors.titleText,
      );

  static TextStyle get tileName => GoogleFonts.inter(
        fontSize: AppDimens.tileNameFontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.tileNameText,
      );

  static TextStyle get tileGreeting => GoogleFonts.inter(
        fontSize: AppDimens.tileGreetingFontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.tileGreetingText,
      );

  static TextStyle get buttonLabel => GoogleFonts.inter(
        fontSize: AppDimens.buttonFontSize,
        fontWeight: FontWeight.w700,
        height: 1.0,
        color: AppColors.buttonText,
      );
}
