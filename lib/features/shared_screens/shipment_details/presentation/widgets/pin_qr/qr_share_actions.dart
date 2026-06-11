import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';

class QrShareActions extends StatelessWidget {
  final bool isSavingImage;
  final VoidCallback onShareImage;

  const QrShareActions({
    super.key,
    required this.isSavingImage,
    required this.onShareImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: _ShareImageButton(
        loading: isSavingImage,
        onTap: onShareImage,
      ),
    );
  }
}

class _ShareImageButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onTap;

  const _ShareImageButton({required this.loading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        decoration: BoxDecoration(
          gradient: loading
              ? null
              : LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: loading ? AppColors.primary.withValues(alpha: 0.55) : null,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: loading
              ? null
              : [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              SizedBox(
                width: 18.sp,
                height: 18.sp,
                child: const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            else
              Icon(Icons.image_rounded, color: Colors.white, size: 20.sp),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  loading ? 'جارٍ تجهيز الصورة...' : 'مشاركة كصورة',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.sp,
                  ),
                ),
                if (!loading)
                  Text(
                    'WhatsApp · Telegram · حفظ في الصور',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.70),
                      fontSize: 10.sp,
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
