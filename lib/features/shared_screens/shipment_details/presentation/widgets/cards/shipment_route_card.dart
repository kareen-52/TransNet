import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/card_decoration.dart';

class ShipmentRouteCard extends StatelessWidget {
  final ShipmentEntity shipment;
  final bool isDark;

  const ShipmentRouteCard({
    super.key,
    required this.shipment,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final secondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: buildCardDecoration(
        surface: surface,
        border: border,
        isDark: isDark,
      ),
      child: Row(
        children: [
          Expanded(
            child: _RouteEndpoint(
              label: 'نقطة الانطلاق',
              city: shipment.startGovernorate,
              dotColor: AppColors.success,
              align: CrossAxisAlignment.start,
              context: context,
              secondary: secondary,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                _DashedConnector(isDark: isDark),
                SizedBox(height: 4.h),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 18.sp,
                  color: secondary,
                ),
              ],
            ),
          ),
          Expanded(
            child: _RouteEndpoint(
              label: 'الوجهة',
              city: shipment.endGovernorate,
              dotColor: Theme.of(context).colorScheme.error,
              align: CrossAxisAlignment.end,
              context: context,
              secondary: secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteEndpoint extends StatelessWidget {
  final String label;
  final String city;
  final Color dotColor;
  final CrossAxisAlignment align;
  final BuildContext context;
  final Color secondary;

  const _RouteEndpoint({
    required this.label,
    required this.city,
    required this.dotColor,
    required this.align,
    required this.context,
    required this.secondary,
  });

  @override
  Widget build(BuildContext ctx) {
    final isLeft = align == CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Row(
          mainAxisAlignment: isLeft
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            if (!isLeft) ...[
              Text(
                label,
                style: TextStyle(fontSize: 10.sp, color: secondary),
              ),
              SizedBox(width: 6.w),
            ],
            _LocationDot(color: dotColor),
            if (isLeft) ...[
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(fontSize: 10.sp, color: secondary),
              ),
            ],
          ],
        ),
        SizedBox(height: 5.h),
        Text(
          city,
          style: Theme.of(
            ctx,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          textAlign: isLeft ? TextAlign.start : TextAlign.end,
        ),
      ],
    );
  }
}

class _LocationDot extends StatelessWidget {
  final Color color;
  const _LocationDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.w,
      height: 10.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

class _DashedConnector extends StatelessWidget {
  final bool isDark;
  const _DashedConnector({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      height: 2.h,
      child: CustomPaint(painter: _DashedPainter(isDark: isDark)),
    );
  }
}

class _DashedPainter extends CustomPainter {
  final bool isDark;
  const _DashedPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? AppColors.darkBorder : AppColors.lightBorder
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    double x = 0;
    const dashW = 4.0, gapW = 3.0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset(x + dashW, size.height / 2),
        paint,
      );
      x += dashW + gapW;
    }
  }

  @override
  bool shouldRepaint(_DashedPainter old) => old.isDark != isDark;
}
