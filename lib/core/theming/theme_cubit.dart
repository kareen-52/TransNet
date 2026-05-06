import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/theming/theme_cash_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {

  ThemeCubit(super.initialTheme);

  void toggleTheme() async {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newTheme);
    await ThemeCacheHelper.saveTheme(newTheme);
  }


  void setTheme(ThemeMode mode) async {
    emit(mode);
    await ThemeCacheHelper.saveTheme(mode);
  }
}