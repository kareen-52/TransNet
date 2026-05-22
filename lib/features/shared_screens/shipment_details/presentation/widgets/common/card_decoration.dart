import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralised card decoration factory.
///
/// Every card in the Shipment Details feature uses this single source of truth
/// for surface colour, border, radius and shadow — ensuring visual consistency
/// and making global style changes a one-line edit.
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
