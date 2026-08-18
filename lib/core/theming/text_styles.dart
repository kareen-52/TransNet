import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'font_weight_helper.dart';

class TextStyles {
  static String get fontFamily => GoogleFonts.cairo().fontFamily!;

  static TextTheme light = TextTheme(
    displayLarge: GoogleFonts.cairo(
      fontSize: 28.sp,
      fontWeight: FontWeightHelper.bold,
      color: AppColors.lightTextPrimary,
    ),

    displayMedium: GoogleFonts.cairo(
      fontSize: 24.sp,
      fontWeight: FontWeightHelper.bold,
      color: AppColors.lightTextPrimary,
    ),

    headlineSmall: GoogleFonts.cairo(
      fontSize: 20.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: AppColors.lightTextPrimary,
    ),

    titleLarge: GoogleFonts.cairo(
      fontSize: 18.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: AppColors.lightTextPrimary,
    ),

    titleMedium: GoogleFonts.cairo(
      fontSize: 16.sp,
      fontWeight: FontWeightHelper.medium,
      color: AppColors.lightTextPrimary,
    ),

    bodyLarge: GoogleFonts.cairo(
      fontSize: 16.sp,
      height: 1.5,
      fontWeight: FontWeightHelper.regular,
      color: AppColors.lightTextPrimary,
    ),

    bodyMedium: GoogleFonts.cairo(
      fontSize: 14.sp,
      height: 1.5,
      fontWeight: FontWeightHelper.regular,
      color: AppColors.lightTextSecondary,
    ),

    bodySmall: GoogleFonts.cairo(
      fontSize: 12.sp,
      fontWeight: FontWeightHelper.regular,
      color: AppColors.lightTextSecondary,
    ),

    labelLarge: GoogleFonts.cairo(
      fontSize: 16.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: Colors.white,
    ),

    labelMedium: GoogleFonts.cairo(
      fontSize: 14.sp,
      fontWeight: FontWeightHelper.medium,
      color: AppColors.lightTextPrimary,
    ),

    labelSmall: GoogleFonts.cairo(
      fontSize: 12.sp,
      fontWeight: FontWeightHelper.medium,
      color: AppColors.lightTextSecondary,
    ),
  );

  static TextTheme dark = TextTheme(
    displayLarge: GoogleFonts.cairo(
      fontSize: 28.sp,
      fontWeight: FontWeightHelper.bold,
      color: AppColors.darkTextPrimary,
    ),

    displayMedium: GoogleFonts.cairo(
      fontSize: 24.sp,
      fontWeight: FontWeightHelper.bold,
      color: AppColors.darkTextPrimary,
    ),

    headlineSmall: GoogleFonts.cairo(
      fontSize: 20.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: AppColors.darkTextPrimary,
    ),

    titleLarge: GoogleFonts.cairo(
      fontSize: 18.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: AppColors.darkTextPrimary,
    ),

    titleMedium: GoogleFonts.cairo(
      fontSize: 16.sp,
      fontWeight: FontWeightHelper.medium,
      color: AppColors.darkTextPrimary,
    ),

    bodyLarge: GoogleFonts.cairo(
      fontSize: 16.sp,
      height: 1.5,
      fontWeight: FontWeightHelper.regular,
      color: AppColors.darkTextPrimary,
    ),

    bodyMedium: GoogleFonts.cairo(
      fontSize: 14.sp,
      height: 1.5,
      fontWeight: FontWeightHelper.regular,
      color: AppColors.darkTextSecondary,
    ),

    bodySmall: GoogleFonts.cairo(
      fontSize: 12.sp,
      fontWeight: FontWeightHelper.regular,
      color: AppColors.darkTextSecondary,
    ),

    labelLarge: GoogleFonts.cairo(
      fontSize: 16.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: Colors.white,
    ),

    labelMedium: GoogleFonts.cairo(
      fontSize: 14.sp,
      fontWeight: FontWeightHelper.medium,
      color: AppColors.darkTextPrimary,
    ),

    labelSmall: GoogleFonts.cairo(
      fontSize: 12.sp,
      fontWeight: FontWeightHelper.medium,
      color: AppColors.darkTextSecondary,
    ),
  );

  static TextStyle forgetPass(BuildContext context) => Theme.of(context)
      .textTheme
      .labelSmall!
      .copyWith(color: AppColors.primary, fontWeight: FontWeightHelper.thin);

  static TextStyle createAccount(BuildContext context) => Theme.of(context)
      .textTheme
      .labelMedium!
      .copyWith(color: Color(0xFFF28B0D), fontWeight: FontWeightHelper.bold);

  static TextStyle success(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
        color:Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeightHelper.semiBold,
      );

  static TextStyle warning(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeightHelper.semiBold,
      );

  static TextStyle error(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyMedium!
      .copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeightHelper.semiBold);
}
