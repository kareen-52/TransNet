import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';

/// PIN display + inline copy button shown below the QR card
/// inside [QrFullscreenModal].
class QrPinRow extends StatelessWidget {
  final String pin;
  final bool copied;
  final VoidCallback onCopy;

  const QrPinRow({
    super.key,
    required this.pin,
    required this.copied,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            pin,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 6,
            ),
          ),
          SizedBox(width: 14.w),
          _InlineCopyBtn(copied: copied, onCopy: onCopy),
        ],
      ),
    );
  }
}

class _InlineCopyBtn extends StatelessWidget {
  final bool copied;
  final VoidCallback onCopy;

  const _InlineCopyBtn({required this.copied, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCopy,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: copied
              ? AppColors.success
              : Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              copied ? Icons.check_rounded : Icons.copy_rounded,
              color: Colors.white,
              size: 14.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              copied ? 'تم' : 'نسخ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
