import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A single action row (icon + label + optional subtitle) used inside
/// [ShareBottomSheet]. Extracted so it can be reused independently.
class ShareActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  const ShareActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 20.sp),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: textColor.withValues(alpha: 0.65),
                      fontSize: 11.sp,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
