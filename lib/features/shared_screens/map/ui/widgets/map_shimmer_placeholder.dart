import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class MapShimmerPlaceholder extends StatelessWidget {
  final double? height;
  final double borderRadius;

  const MapShimmerPlaceholder({
    super.key,
    this.height,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? AppColors.darkSurfaceVariant : AppColors.lightBorder;
    final highlight = isDark ? AppColors.darkBorder : AppColors.lightSurface;

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: Container(
          height: height,
          width: double.infinity,
          color: Colors.white,
          child: CustomPaint(painter: _GridPainter()),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..strokeWidth = 1;

    const step = 36.0;
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
