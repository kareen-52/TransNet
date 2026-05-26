import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';


class CopyButton extends StatelessWidget {
  final bool copied;
  final String label;
  final VoidCallback onTap;

  const CopyButton({
    super.key,
    required this.copied,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = copied ? AppColors.success : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              copied ? Icons.check_rounded : Icons.copy_rounded,
              size: 14.sp,
              color: Colors.white,
            ),
            SizedBox(width: 6.w),
            Text(
              copied ? 'تم النسخ ✓' : label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
