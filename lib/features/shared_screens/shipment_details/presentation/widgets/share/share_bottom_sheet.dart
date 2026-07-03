import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/utils/date_formatter.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/share/share_action_tile.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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

  Future<void> _shareViaApp() async {
    HapticFeedback.lightImpact();
    await Share.share(widget.shareText, subject: 'تفاصيل الشحنة');
  }

  Future<void> _shareAsPdf() async {
    setState(() => _generatingPdf = true);
    HapticFeedback.lightImpact();
    try {
      final regularFontData = await rootBundle.load(
        'assets/fonts/NotoNaskhArabic-Regular.ttf',
      );
      final boldFontData = await rootBundle.load(
        'assets/fonts/NotoNaskhArabic-Bold.ttf',
      );
      final arabicRegular = pw.Font.ttf(regularFontData);
      final arabicBold = pw.Font.ttf(boldFontData);

      final pdf = pw.Document(
        theme: pw.ThemeData.withFont(base: arabicRegular, bold: arabicBold),
      );

      final s = widget.data.shipment;

      final driver = widget.data.hasDriver ? widget.data.driver : null;
      final client = widget.data.hasClient ? widget.data.client : null;

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(36),
          build: (pw.Context ctx) {
            return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(16),
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('#1565C0'),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'تفاصيل الشحنة',
                          style: pw.TextStyle(
                            font: arabicBold,
                            fontSize: 22,
                            color: PdfColors.white,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'شحنة #${s.shipmentNumber}  •  ${s.status}',
                          style: pw.TextStyle(
                            font: arabicRegular,
                            fontSize: 12,
                            color: PdfColors.grey300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 24),

                  _pdfSection(
                    arabicBold,
                    arabicRegular,
                    title: 'مسار الشحنة',
                    rows: [
                      [s.startGovernorate, 'من'],
                      [s.endGovernorate, 'إلى'],
                    ],
                  ),
                  pw.SizedBox(height: 16),

                  if (s.price != null)
                    _pdfSection(
                      arabicBold,
                      arabicRegular,
                      title: 'التفاصيل المالية',
                      rows: [
                        if (s.price != null) ['${s.price} ل.س', 'السعر'],
                        // if (s.insurance != null)
                        //   [s.hasInsurance ? 'مؤمَّن' : 'غير مؤمَّن', 'التأمين'],
                      ],
                    ),
                  pw.SizedBox(height: 16),

                  if (s.object != null || s.weight != null)
                    _pdfSection(
                      arabicBold,
                      arabicRegular,
                      title: 'البضاعة',
                      rows: [
                        if (s.object != null) [s.object!, 'النوع'],
                        if (s.weight != null) ['${s.weight} كغم', 'الوزن'],
                      ],
                    ),
                  pw.SizedBox(height: 16),

                  if (driver != null)
                    _pdfSection(
                      arabicBold,
                      arabicRegular,
                      title: 'السائق',
                      rows: [
                        [driver.fullName, 'الاسم'],
                        [driver.phoneNumber, 'الهاتف'],
                      ],
                    ),
                  if (client != null)
                    _pdfSection(
                      arabicBold,
                      arabicRegular,
                      title: 'العميل',
                      rows: [
                        [client.firstName, 'الاسم'],
                        [client.phoneNumber, 'الهاتف'],
                      ],
                    ),
                  pw.SizedBox(height: 16),

                  if (s.hasPin)
                    _pdfSection(
                      arabicBold,
                      arabicRegular,
                      title: 'رمز التسليم',
                      rows: [
                        [s.pin!, 'PIN'],
                      ],
                    ),

                  pw.Spacer(),

                  pw.Divider(),
                  pw.Text(
                    " تم الإنشاء عبر تطبيق الشحن     •  ${DateFormatter.format(DateTime.now().toIso8601String())}",
                    style: pw.TextStyle(
                      font: arabicRegular,
                      fontSize: 9,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/shipment_${s.shipmentNumber}.pdf';
      final file = File(path);
      await file.writeAsBytes(await pdf.save());
      await Share.shareXFiles([
        XFile(path, mimeType: 'application/pdf'),
      ], subject: 'تفاصيل الشحنة #${s.shipmentNumber}');
    } catch (e) {
      if (mounted) _showSnack('خطأ أثناء إنشاء PDF: $e', isError: true);
    } finally {
      if (mounted) setState(() => _generatingPdf = false);
    }
  }

  static pw.Widget _pdfSection(
    pw.Font boldFont,
    pw.Font regularFont, {
    required String title,
    required List<List<String>> rows,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            font: boldFont,
            fontSize: 13,
            color: PdfColor.fromHex('#1565C0'),
          ),
        ),
        pw.SizedBox(height: 6),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          children: rows.map((row) {
            return pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    row[0],
                    style: pw.TextStyle(font: boldFont, fontSize: 11),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    row[1],
                    style: pw.TextStyle(font: regularFont, fontSize: 11),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _copyToClipboard({bool pop = false}) async {
    await Clipboard.setData(ClipboardData(text: widget.shareText));
    HapticFeedback.lightImpact();
    if (!mounted) return;
    setState(() => _copied = true);
    if (pop) Navigator.pop(context);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  void _showSnack(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError
            ? Theme.of(context).colorScheme.error
            : AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 80.h),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final secondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          _SheetHeader(shipmentNumber: widget.data.shipment.shipmentNumber),
          SizedBox(height: 20.h),
          _TextPreview(
            text: widget.shareText,
            isDark: isDark,
            border: border,
            secondary: secondary,
          ),
          SizedBox(height: 20.h),

          ShareActionTile(
            icon: _generatingPdf ? null : Icons.picture_as_pdf_rounded,
            label: _generatingPdf ? 'جارٍ إنشاء PDF...' : 'مشاركة كـ PDF',

            bgColor: const Color(0xFFE53935),
            textColor: Colors.white,
            loading: _generatingPdf,
            onTap: _generatingPdf ? () {} : _shareAsPdf,
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
            onTap: () => _copyToClipboard(),
          ),
        ],
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
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.share_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مشاركة تفاصيل الشحنة',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              'شحنة #$shipmentNumber',
              style: TextStyle(fontSize: 12.sp, color: secondary),
            ),
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
        style: TextStyle(fontSize: 11.sp, color: secondary, height: 1.6),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
