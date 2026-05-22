import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/shimmer_box.dart';

/// Loading skeleton shown while shipment data is being fetched.
///
/// Uses [ShimmerBox] primitives to render a believable content placeholder
/// that matches the actual content layout — reducing perceived load time.
class ShipmentDetailsLoadingView extends StatelessWidget {
  const ShipmentDetailsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final high = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return SafeArea(
      child: Column(
        children: [
          // Fake AppBar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Row(
              children: [
                ShimmerBox(w: 40.w, h: 40.w, r: 12.r, base: base, high: high),
                SizedBox(width: 12.w),
                ShimmerBox(w: 160.w, h: 22.h, r: 6.r, base: base, high: high),
                const Spacer(),
                ShimmerBox(w: 38.w, h: 38.w, r: 10.r, base: base, high: high),
              ],
            ),
          ),

          // Scrollable skeleton body
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 4.h),
                  // Header card skeleton
                  ShimmerBox(
                      w: double.infinity,
                      h: 100.h,
                      r: 20.r,
                      base: base,
                      high: high),
                  SizedBox(height: 14.h),
                  // PIN + QR skeleton
                  Row(
                    children: [
                      Expanded(
                        child: ShimmerBox(
                            w: double.infinity,
                            h: 130.h,
                            r: 16.r,
                            base: base,
                            high: high),
                      ),
                      SizedBox(width: 10.w),
                      ShimmerBox(
                          w: 100.w, h: 130.h, r: 16.r, base: base, high: high),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  // Route skeleton
                  ShimmerBox(
                      w: double.infinity,
                      h: 80.h,
                      r: 16.r,
                      base: base,
                      high: high),
                  SizedBox(height: 14.h),
                  // Map skeleton
                  ShimmerBox(
                      w: double.infinity,
                      h: 200.h,
                      r: 16.r,
                      base: base,
                      high: high),
                  SizedBox(height: 14.h),
                  // Cargo skeleton
                  ShimmerBox(
                      w: double.infinity,
                      h: 180.h,
                      r: 16.r,
                      base: base,
                      high: high),
                  SizedBox(height: 14.h),
                  // Status skeleton
                  ShimmerBox(
                      w: double.infinity,
                      h: 130.h,
                      r: 16.r,
                      base: base,
                      high: high),
                  SizedBox(height: 14.h),
                  // Party skeleton
                  ShimmerBox(
                      w: double.infinity,
                      h: 80.h,
                      r: 16.r,
                      base: base,
                      high: high),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
