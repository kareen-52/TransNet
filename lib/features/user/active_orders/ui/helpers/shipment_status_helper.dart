import 'package:flutter/material.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';

class ShipmentStatusHelper {
  static Color getColor(String? status, {bool isCompleted = false}) {
    if (isCompleted || status == 'مستلمة') {
      return AppColors.success;
    }

    switch (status) {
      case 'جارية':
        return AppColors.secondary;
      case 'قيد التوصيل':
        return AppColors.primary;

      default:
        return AppColors.secondary;
    }
  }


  static int getStepIndex(String? status, {bool isCompleted = false}) {
    if (isCompleted || status == 'مستلمة') return 3;

    switch (status) {
      case 'جارية':
        return 1; 
      case 'قيد التوصيل':
        return 2;
      default:
        return 0;
    }
  }
}
