import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';

class RowDivider extends StatelessWidget {
  final bool isDark;

  const RowDivider({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 16.h,
      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
    );
  }
}
