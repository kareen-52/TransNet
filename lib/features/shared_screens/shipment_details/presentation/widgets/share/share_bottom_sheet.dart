import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/share/share_action_tile.dart';

/// Bottom sheet for sharing shipment details.
/// Opened exclusively through [ShareBottomSheet.show].
class ShareBottomSheet extends StatefulWidget {
  final ShipmentDetailsEntity data;
  final String shareText;

  const ShareBottomSheet._({required this.data, required this.shareText});

  static Future<void> show(
    BuildContext context, {
    required ShipmentDetailsEntity data,
    required String shareText,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ShareBottomSheet._(data: data, shareText: shareText),
    );
  }

  @override
  State<ShareBottomSheet> createState() => _ShareBottomSheetState();
}

class _ShareBottomSheetState extends State<ShareBottomSheet> {
  bool _copied = false;

  Future<void> _shareViaApp() async {
    // await Share.share(widget.shareText, subject: 'تفاصيل الشحنة');
    await _copyToClipboard();
    if (mounted) Navigator.pop(context);
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.shareText));
    HapticFeedback.lightImpact();
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final secondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SheetHandle(isDark: isDark),
          SizedBox(height: 20.h),
          _SheetHeader(shipmentNumber: widget.data.shipment.shipmentNumber),
          SizedBox(height: 20.h),
          _TextPreview(
              text: widget.shareText,
              isDark: isDark,
              border: border,
              secondary: secondary),
          SizedBox(height: 20.h),
          ShareActionTile(
            icon: Icons.share_rounded,
            label: 'مشاركة عبر التطبيقات',
            subtitle: 'WhatsApp, Telegram, ...',
            bgColor: AppColors.primary,
            textColor: Colors.white,
            onTap: _shareViaApp,
          ),
          SizedBox(height: 10.h),
          ShareActionTile(
            icon: _copied ? Icons.check_rounded : Icons.copy_all_rounded,
            label: _copied ? 'تم النسخ ✓' : 'نسخ التفاصيل',
            subtitle: 'انسخ النص ثم الصقه يدوياً',
            bgColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            textColor: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
            onTap: _copyToClipboard,
          ),
        ],
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  final bool isDark;
  const _SheetHandle({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.15)
            : Colors.black.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  final int shipmentNumber;
  const _SheetHeader({required this.shipmentNumber});

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child:
              Icon(Icons.share_rounded, color: AppColors.primary, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('مشاركة تفاصيل الشحنة',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            Text('شحنة #$shipmentNumber',
                style: TextStyle(fontSize: 12.sp, color: secondary)),
          ],
        ),
      ],
    );
  }
}

class _TextPreview extends StatelessWidget {
  final String text;
  final bool isDark;
  final Color border;
  final Color secondary;

  const _TextPreview({
    required this.text,
    required this.isDark,
    required this.border,
    required this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    final preview = text.length > 280 ? '${text.substring(0, 280)}...' : text;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: border),
      ),
      child: Text(
        preview,
        style: TextStyle(
          fontSize: 11.sp,
          color: secondary,
          height: 1.6,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}
