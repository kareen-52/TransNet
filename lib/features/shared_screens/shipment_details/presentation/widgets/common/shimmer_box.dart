import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable shimmer animation box used in skeleton loading views.
///
/// Uses a single [AnimationController] per instance for independent
/// animation timing — no shared controllers, no unnecessary rebuilds.
class ShimmerBox extends StatefulWidget {
  final double w;
  final double h;
  final double r;
  final Color base;
  final Color high;

  const ShimmerBox({
    super.key,
    required this.w,
    required this.h,
    required this.r,
    required this.base,
    required this.high,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Container(
        width: widget.w,
        height: widget.h,
        decoration: BoxDecoration(
          color: Color.lerp(widget.base, widget.high, _animation.value),
          borderRadius: BorderRadius.circular(widget.r),
        ),
      ),
    );
  }
}
