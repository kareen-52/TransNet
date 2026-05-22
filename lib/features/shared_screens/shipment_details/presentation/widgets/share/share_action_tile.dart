import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A single action row (icon + label + optional subtitle) used inside
/// [ShareBottomSheet]. Extracted so it can be reused independently.
///
/// Supports a [loading] state that shows a spinner instead of the icon.
class ShareActionTile extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String? subtitle;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;
  final bool loading;

  const ShareActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
    this.subtitle,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: loading ? bgColor.withValues(alpha: 0.65) : bgColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            if (loading)
              SizedBox(
                width: 20.sp,
                height: 20.sp,
                child: CircularProgressIndicator(
                    color: textColor, strokeWidth: 2.0),
              )
            else
              Icon(icon, color: textColor, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
            ),
            if (!loading)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: textColor.withValues(alpha: 0.50),
                size: 14.sp,
              ),
          ],
        ),
      ),
    );
  }
}
