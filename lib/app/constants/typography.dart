import 'package:flutter/material.dart';
import 'colors.dart';

/// App typography
/// This class contains all the text styles used in the application
class AppTypography {
  // Font family
  static const String fontFamily = 'Poppins';

  // Font weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Display styles (61px / 3.812rem)
  static TextStyle displayRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 61,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.2, // Approximate line height
  );

  static TextStyle displaySemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 61,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle displayBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 61,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // Heading 1 styles (49px / 3.062rem)
  static TextStyle h1Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 49,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle h1SemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 49,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle h1Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 49,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // Heading 2 styles (39px / 2.438rem)
  static TextStyle h2Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 39,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle h2SemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 39,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle h2Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 39,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Heading 3 styles (31px / 1.938rem)
  static TextStyle h3Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 31,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle h3SemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 31,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle h3Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 31,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Heading 4 styles (25px / 1.562rem)
  static TextStyle h4Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 25,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle h4SemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 25,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle h4Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 25,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Heading 5 styles (20px / 1.250rem)
  static TextStyle h5Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle h5SemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle h5Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body Large styles (16px / 1.000rem)
  static TextStyle bodyLargeRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle bodyLargeSemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle bodyLargeBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // Body Medium styles (13px / 0.812rem)
  static TextStyle bodyMediumRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle bodyMediumSemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle bodyMediumBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // Body Small styles (10px / 0.625rem)
  static TextStyle bodySmallRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle bodySmallSemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle bodySmallBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.5,
  );
}
