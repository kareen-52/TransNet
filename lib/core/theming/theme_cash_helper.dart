import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';

class ThemeCacheHelper {
  static Future<void> saveTheme(ThemeMode mode) async {
    await SharedPrefHelper.setData(SharedPrefKeys.themeMode, mode.name);
  }

  static Future<ThemeMode> getTheme() async {
    final String themeName = SharedPrefHelper.getString(SharedPrefKeys.themeMode);
  
    if ( themeName.isEmpty) {
      return ThemeMode.system;
    }


    return ThemeMode.values.firstWhere(
      (e) => e.name == themeName,
      orElse: () => ThemeMode.system,
    );
  }
}