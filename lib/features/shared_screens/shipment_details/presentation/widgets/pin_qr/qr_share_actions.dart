import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';

/// Three-button share row displayed at the bottom of the QR modal:
///   1. Share as image (primary)
///   2. Share as text
///   3. Copy pin
class QrShareActions extends StatelessWidget {
  final bool isSavingImage;
  final bool copied;
  final VoidCallback onShareImage;
  final VoidCallback onShareText;
  final VoidCallback onCopy;

  const QrShareActions({
    super.key,
    required this.isSavingImage,
    required this.copied,
    required this.onShareImage,
    required this.onShareText,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ShareTile(
          icon: isSavingImage ? null : Icons.image_rounded,
          label: isSavingImage ? 'جارٍ الحفظ...' : 'مشاركة كصورة',
          subtitle: 'WhatsApp, Telegram, ...',
          bgColor: AppColors.primary,
          loading: isSavingImage,
          onTap: onShareImage,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: _ShareTile(
                icon: Icons.share_rounded,
                label: 'مشاركة الرمز',
                bgColor: Colors.white.withValues(alpha: 0.15),
                bordered: true,
                onTap: onShareText,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _ShareTile(
                icon: copied ? Icons.check_rounded : Icons.copy_rounded,
                label: copied ? 'تم النسخ' : 'نسخ',
                bgColor: Colors.white.withValues(alpha: 0.15),
                bordered: true,
                onTap: onCopy,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ShareTile extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String? subtitle;
  final Color bgColor;
  final bool bordered;
  final bool loading;
  final VoidCallback onTap;

  const _ShareTile({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.onTap,
    this.subtitle,
    this.bordered = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14.r),
          border: bordered
              ? Border.all(color: Colors.white.withValues(alpha: 0.20))
              : null,
        ),
        child: Row(
          mainAxisAlignment: subtitle != null
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            if (loading)
              SizedBox(
                width: 16.w,
                height: 16.w,
                child: const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            else
              Icon(icon, color: Colors.white, size: 18.sp),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp)),
                if (subtitle != null)
                  Text(subtitle!,
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.60),
                          fontSize: 10.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
