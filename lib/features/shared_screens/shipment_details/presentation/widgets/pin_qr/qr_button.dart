import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/pin_qr/qr_fullscreen_modal.dart';

/// Compact QR card button that opens the full-screen QR viewer on tap.
///
/// The card itself is purely decorative — a gradient icon + label
/// that clearly communicates "tap me to see the QR code".
class QrButton extends StatelessWidget {
  final String qrPin;
  final bool isDark;

  const QrButton({super.key, required this.qrPin, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _openFullscreen(context);
      },
      child: Container(
        width: 110.w,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.12),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _QrIcon(),
            SizedBox(height: 10.h),
            Text(
              'رمز QR',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 3.h),
            _TapHint(),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  void _openFullscreen(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black.withValues(alpha: 0.70),
        pageBuilder: (_, __, ___) => QrFullscreenModal(qrPin: qrPin),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.10),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
            child: child,
          ),
        ),
        transitionDuration: const Duration(milliseconds: 280),
      ),
    );
  }
}

class _QrIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.30),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(Icons.qr_code_2_rounded, size: 28.sp, color: Colors.white),
    );
  }
}

class _TapHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        'اضغط للفتح',
        style: TextStyle(
          color: AppColors.primary.withValues(alpha: 0.70),
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
