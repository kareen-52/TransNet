import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';

/// Placeholder shown in place of the map when no route data is available.
class MapNoRouteCard extends StatelessWidget {
  final bool isDark;

  const MapNoRouteCard({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final secondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map_outlined, size: 32.sp, color: secondary),
          SizedBox(height: 8.h),
          Text(
            'لا يوجد مسار متاح',
            style: TextStyle(color: secondary, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
