import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';

/// Thin horizontal divider that separates [InfoRow] items inside cards.
///
/// Uses the theme-aware border colour so it blends correctly in both
/// dark and light mode without any extra parameters.
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
