import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconButtonHeader extends StatelessWidget {
  final IconData icon;
  const IconButtonHeader({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(color: theme.colorScheme.outline, width: 0.5.w),
      ),
      child: Icon(icon, color: theme.colorScheme.onSurface, size: 25.sp),
    );
  }
}