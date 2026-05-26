import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


BoxDecoration buildCardDecoration({
  required Color surface,
  required Color border,
  required bool isDark,
}) {
  return BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(16.r),
    border: Border.all(color: border),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.04),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
