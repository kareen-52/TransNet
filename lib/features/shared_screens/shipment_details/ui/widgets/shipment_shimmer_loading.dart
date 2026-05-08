import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';

// ─── Shimmer Loading ──────────────────────────────────────────────────────────

class ShipmentShimmerLoading extends StatelessWidget {
  final bool isDark;
  const ShipmentShimmerLoading({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final base = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final high = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return SafeArea(
      child: Column(
        children: [
          // Fake AppBar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              children: [
                _ShimmerBox(w: 38.w, h: 38.w, radius: 12.r, base: base, high: high),
                SizedBox(width: 12.w),
                _ShimmerBox(w: 140.w, h: 20.h, radius: 6.r, base: base, high: high),
                const Spacer(),
                _ShimmerBox(w: 38.w, h: 38.w, radius: 12.r, base: base, high: high),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  // Header card
                  _ShimmerBox(w: double.infinity, h: 90.h, radius: 20.r, base: base, high: high),
                  SizedBox(height: 12.h),
                  // PIN/QR row
                  Row(
                    children: [
                      Expanded(child: _ShimmerBox(w: double.infinity, h: 120.h, radius: 16.r, base: base, high: high)),
                      SizedBox(width: 10.w),
                      _ShimmerBox(w: 100.w, h: 120.h, radius: 16.r, base: base, high: high),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Section label
                  _ShimmerBox(w: 100.w, h: 14.h, radius: 4.r, base: base, high: high),
                  SizedBox(height: 8.h),
                  _ShimmerBox(w: double.infinity, h: 72.h, radius: 16.r, base: base, high: high),
                  SizedBox(height: 12.h),
                  // Map card
                  _ShimmerBox(w: 100.w, h: 14.h, radius: 4.r, base: base, high: high),
                  SizedBox(height: 8.h),
                  _ShimmerBox(w: double.infinity, h: 180.h, radius: 20.r, base: base, high: high),
                  SizedBox(height: 12.h),
                  // Details
                  _ShimmerBox(w: 120.w, h: 14.h, radius: 4.r, base: base, high: high),
                  SizedBox(height: 8.h),
                  _ShimmerBox(w: double.infinity, h: 200.h, radius: 16.r, base: base, high: high),
                  SizedBox(height: 12.h),
                  // Status
                  _ShimmerBox(w: 100.w, h: 14.h, radius: 4.r, base: base, high: high),
                  SizedBox(height: 8.h),
                  _ShimmerBox(w: double.infinity, h: 120.h, radius: 16.r, base: base, high: high),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shimmer Box ──────────────────────────────────────────────────────────────

class _ShimmerBox extends StatefulWidget {
  final double w, h, radius;
  final Color base, high;

  const _ShimmerBox({
    required this.w,
    required this.h,
    required this.radius,
    required this.base,
    required this.high,
  });

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100))
      ..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: widget.w,
        height: widget.h,
        decoration: BoxDecoration(
          color: Color.lerp(widget.base, widget.high, _anim.value),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}