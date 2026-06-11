import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'text_styles.dart';

class AppTheme {
  static const double _radius = 16;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: TextStyles.fontFamily,
    canvasColor: AppColors.lightBackground,

    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: TextStyles.light,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.lightSurface,
      error: AppColors.error,

      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.lightTextPrimary,

      outline: AppColors.lightBorder,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,

      onSecondaryContainer: AppColors.secondaryDark,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.lightTextPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,

    ),

    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 1,
      shadowColor: Colors.black.withOpacity(.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
    ),

    primaryIconTheme: IconThemeData(),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return AppColors.disabled;
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryDark;
          }
          return AppColors.primary;
        }),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        minimumSize: WidgetStateProperty.all(Size.fromHeight(48)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
        ),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightSurface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightTextSecondary,
      type: BottomNavigationBarType.fixed,
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStateProperty.all(BorderSide(color: AppColors.primary)),
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
        minimumSize: WidgetStateProperty.all(Size.fromHeight(48)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightInputFill,

      hintStyle: TextStyles.light.bodyMedium!.copyWith(
        color: AppColors.lightTextSecondary,
      ),
      iconColor: AppColors.lightTextSecondary,
      prefixIconColor: AppColors.lightTextSecondary,
      suffixIconColor: AppColors.lightTextSecondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.lightInputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.lightInputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide(color: AppColors.lightBorder.withOpacity(0.5)),
      ),

      errorStyle: TextStyles.light.labelSmall?.copyWith(
        color: AppColors.error,
        fontSize: 12,
      ),

      floatingLabelStyle: const TextStyle(color: AppColors.primary),
    ),

    iconTheme: const IconThemeData(color: AppColors.lightTextPrimary, size: 24),

    dividerTheme: const DividerThemeData(
      color: AppColors.lightBorder,
      thickness: 1,
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.primary,
      textColor: AppColors.lightTextPrimary,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.primary),
      trackColor: WidgetStateProperty.all(AppColors.primary.withOpacity(.3)),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColors.primary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightSurface,
      color: WidgetStatePropertyAll(AppColors.primary.withOpacity(0.1)),
      selectedColor: AppColors.primary,
      labelStyle: TextStyles.light.labelMedium!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(width: 0.5, color: AppColors.primary),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lightBorder,
      contentTextStyle: TextStyles.light.labelMedium?.copyWith(
        color: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.lightSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
      titleTextStyle: TextStyles.light.titleLarge,
      contentTextStyle: TextStyles.light.bodyMedium,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primary.withOpacity(.2),
    ),

    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.lightTextSecondary,
      indicatorColor: AppColors.primary,
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyles.light.bodySmall,
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: Color(0x332563EB),
      selectionHandleColor: AppColors.primary,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondary,
      foregroundColor: Colors.white,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.lightSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: TextStyles.fontFamily,
    canvasColor: AppColors.darkBackground,

    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: TextStyles.dark,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surface: AppColors.darkSurface,
      error: AppColors.error,

      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.darkTextPrimary,

      outline: AppColors.darkBorder,
      onSecondaryContainer: Colors.white,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
    ),

    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
   
    ),

    cardTheme: CardThemeData(
      shadowColor: Colors.black.withOpacity(.05),
      color: AppColors.darkSurface,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return AppColors.disabled;
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryDark;
          }
          return AppColors.primaryLight;
        }),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        minimumSize: WidgetStateProperty.all(Size.fromHeight(48)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
        ),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.secondaryLight,
      unselectedItemColor: AppColors.darkTextSecondary,
      type: BottomNavigationBarType.fixed,
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStateProperty.all(
          BorderSide(color: AppColors.primaryLight),
        ),
        foregroundColor: WidgetStateProperty.all(AppColors.primaryLight),
        minimumSize: WidgetStateProperty.all(Size.fromHeight(48)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primaryLight),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInputFill,
      hintStyle: TextStyles.light.bodyMedium!.copyWith(
        color: AppColors.darkTextSecondary,
      ),
      labelStyle: TextStyles.dark.bodyLarge?.copyWith(
        color: AppColors.darkTextSecondary,
      ),
      iconColor: AppColors.darkTextSecondary,
      prefixIconColor: AppColors.darkTextSecondary,
      suffixIconColor: AppColors.darkTextSecondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.darkInputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.darkInputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide(color: AppColors.darkBorder.withOpacity(0.5)),
      ),
      errorStyle: TextStyles.dark.labelSmall?.copyWith(
        color: AppColors.error,
        fontSize: 12,
      ),
      floatingLabelStyle: const TextStyle(color: AppColors.primaryLight),
    ),

    iconTheme: const IconThemeData(color: AppColors.darkTextPrimary, size: 24),

    dividerTheme: const DividerThemeData(
      color: AppColors.darkBorder,
      thickness: 1,
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.primaryLight,
      textColor: AppColors.darkTextPrimary,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.primaryLight),
      trackColor: WidgetStateProperty.all(
        AppColors.primaryLight.withOpacity(0.3),
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColors.primaryLight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedColor: AppColors.primaryLight,
      color: WidgetStatePropertyAll(AppColors.primaryLight.withOpacity(0.1)),
      labelStyle: TextStyles.dark.labelMedium!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(width: 0.5, color: AppColors.primaryLight),
      ),
    ),

    
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkBorder,
      contentTextStyle: TextStyles.light.labelMedium?.copyWith(
        color: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
      titleTextStyle: TextStyles.dark.titleLarge,
      contentTextStyle: TextStyles.dark.bodyMedium,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryLight,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primaryLight,
      thumbColor: AppColors.primaryLight,
      overlayColor: AppColors.primaryLight.withOpacity(.2),
    ),

    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.primaryLight,
      unselectedLabelColor: AppColors.darkTextSecondary,
      indicatorColor: AppColors.primaryLight,
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyles.dark.bodySmall,
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryLight,
      selectionColor: Color(0x333B82F6),
      selectionHandleColor: AppColors.primaryLight,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryLight,
      foregroundColor: Colors.white,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
  );
}
