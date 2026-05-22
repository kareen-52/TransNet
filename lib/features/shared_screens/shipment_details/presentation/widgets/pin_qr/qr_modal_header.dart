import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Title + close button row at the top of [QrFullscreenModal].
class QrModalHeader extends StatelessWidget {
  final VoidCallback onClose;

  const QrModalHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'رمز QR للشحنة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'أظهر هذا الرمز لتأكيد الاستلام',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onClose,
          child: Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child:
                Icon(Icons.close_rounded, color: Colors.white, size: 18.sp),
          ),
        ),
      ],
    );
  }
}
