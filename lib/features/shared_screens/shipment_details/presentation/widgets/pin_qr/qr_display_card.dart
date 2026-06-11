import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrDisplayCard extends StatelessWidget {
  final GlobalKey repaintKey;
  final String qrPin;

  const QrDisplayCard({
    super.key,
    required this.repaintKey,
    required this.qrPin,
  });

  @override
  Widget build(BuildContext context) {
    final cardSize = math.min(MediaQuery.of(context).size.width - 48.w, 360.0);

    return RepaintBoundary(
      key: repaintKey,
      child: Container(
        width: cardSize,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 40,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BrandingStrip(),
            SizedBox(height: 16.h),
            _QrCodeView(data: qrPin, cardSize: cardSize),
            SizedBox(height: 16.h),
            _ScanHint(),
          ],
        ),
      ),
    );
  }
}

class _BrandingStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.local_shipping_rounded,
            color: AppColors.primary, size: 18.sp),
        SizedBox(width: 6.w),
        Text(
          'شحنتي',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _QrCodeView extends StatelessWidget {
  final String data;
  final double cardSize;

  const _QrCodeView({required this.data, required this.cardSize});

  @override
  Widget build(BuildContext context) {
    final qrSize = (cardSize - 48).clamp(180.0, 280.0);

    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: qrSize,
      backgroundColor: Colors.white,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      embeddedImage: const AssetImage('assets/images/logo.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(size: Size(qrSize * 0.18, qrSize * 0.18)),
    );
 
    return SizedBox(
      width: qrSize,
      height: qrSize,
      child: CustomPaint(painter: QrPlaceholderPainter(seed: data.hashCode)),
    );
  }
}

class _ScanHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.qr_code_scanner_rounded,
              color: AppColors.primary, size: 14.sp),
          SizedBox(width: 5.w),
          Text(
            'امسح بالكاميرا',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}


class QrPlaceholderPainter extends CustomPainter {
  final int seed;
  const QrPlaceholderPainter({required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.fill;
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const cells = 21;
    final cs = size.width / cells;

    void finder(double x, double y) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, cs * 7, cs * 7), const Radius.circular(2)),
        blackPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x + cs, y + cs, cs * 5, cs * 5),
            const Radius.circular(1)),
        whitePaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(x + cs * 2, y + cs * 2, cs * 3, cs * 3),
            const Radius.circular(1)),
        blackPaint,
      );
    }

    finder(0, 0);
    finder((cells - 7) * cs, 0);
    finder(0, (cells - 7) * cs);

    final rng = math.Random(seed);
    for (int row = 0; row < cells; row++) {
      for (int col = 0; col < cells; col++) {
        final inTopLeft = row < 8 && col < 8;
        final inTopRight = row < 8 && col >= cells - 8;
        final inBottomLeft = row >= cells - 8 && col < 8;
        if (inTopLeft || inTopRight || inBottomLeft) continue;
        if (rng.nextBool()) {
          canvas.drawRect(
            Rect.fromLTWH(col * cs + 0.5, row * cs + 0.5, cs - 1, cs - 1),
            blackPaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(QrPlaceholderPainter old) => old.seed != seed;
}
