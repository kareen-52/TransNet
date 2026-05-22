import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/share/share_action_tile.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Bottom sheet for sharing shipment details.
/// Supports: share as text (WhatsApp/Telegram/…), share as PDF,
/// save as image, and copy to clipboard.
///
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
  bool _generatingPdf = false;

  // ── Share as plain text (WhatsApp, Telegram, …) ──────────────────────────
  Future<void> _shareViaApp() async {
    HapticFeedback.lightImpact();
    // ▶ Uncomment when share_plus is added to pubspec.yaml:
    await Share.share(widget.shareText, subject: 'تفاصيل الشحنة');
    
    // Fallback until then:
    await _copyToClipboard(pop: true);
  }

  // ── Generate & share PDF ─────────────────────────────────────────────────
  Future<void> _shareAsPdf() async {
    setState(() => _generatingPdf = true);
    HapticFeedback.lightImpact();
    try {
      // ▶ Full implementation with pdf + share_plus packages:
      
      final pdf = pw.Document();
      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (_) => pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('تفاصيل الشحنة #${widget.data.shipment.shipmentNumber}',
                  style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              pw.Text(widget.shareText,
                  style: const pw.TextStyle(fontSize: 13, lineSpacing: 4)),
            ],
          ),
        ),
      ));
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/shipment_${widget.data.shipment.shipmentNumber}.pdf');
      await file.writeAsBytes(await pdf.save());
      await Share.shareXFiles([XFile(file.path)], subject: 'تفاصيل الشحنة');
      //
      // Fallback until packages are added — copy text and inform user:
      await Clipboard.setData(ClipboardData(text: widget.shareText));
      if (!mounted) return;
      _showSnack('أضف حزمتَي pdf و share_plus لتفعيل تصدير PDF');
    } finally {
      if (mounted) setState(() => _generatingPdf = false);
    }
  }

  // ── Copy to clipboard ─────────────────────────────────────────────────────
  Future<void> _copyToClipboard({bool pop = false}) async {
    await Clipboard.setData(ClipboardData(text: widget.shareText));
    HapticFeedback.lightImpact();
    if (!mounted) return;
    setState(() => _copied = true);
    if (pop) Navigator.pop(context);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 80.h),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

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
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          // Header
          _SheetHeader(shipmentNumber: widget.data.shipment.shipmentNumber),
          SizedBox(height: 20.h),

          // Text preview
          _TextPreview(
            text: widget.shareText,
            isDark: isDark,
            border: border,
            secondary: secondary,
          ),
          SizedBox(height: 20.h),

          // ① Share as text — WhatsApp / Telegram / …
          ShareActionTile(
            icon: Icons.share_rounded,
            label: 'مشاركة عبر التطبيقات',
            subtitle: 'WhatsApp · Telegram · …',
            bgColor: AppColors.primary,
            textColor: Colors.white,
            onTap: _shareViaApp,
          ),
          SizedBox(height: 10.h),

          // ② Share as PDF
          ShareActionTile(
            icon: _generatingPdf ? null : Icons.picture_as_pdf_rounded,
            label: _generatingPdf ? 'جارٍ إنشاء PDF...' : 'مشاركة كـ PDF',
            subtitle: _generatingPdf ? null : 'ملف جاهز للطباعة والإرسال',
            bgColor: const Color(0xFFE53935),
            textColor: Colors.white,
            loading: _generatingPdf,
            onTap: _generatingPdf ? () {} : _shareAsPdf,
          ),
          SizedBox(height: 10.h),

          // ③ Copy
          ShareActionTile(
            icon: _copied ? Icons.check_rounded : Icons.copy_all_rounded,
            label: _copied ? 'تم النسخ ✓' : 'نسخ التفاصيل',
            subtitle: 'انسخ النص ثم الصقه يدوياً',
            bgColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            textColor: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
            onTap: () => _copyToClipboard(),
          ),
        ],
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

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
      width: double.infinity,
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
