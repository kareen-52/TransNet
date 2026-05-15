import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ActiveDriverShipmentsShimmer
// يُعرض أثناء التحميل — كارتان وهميتان
// ─────────────────────────────────────────────────────────────────────────────

class ActiveDriverShipmentsShimmer extends StatelessWidget {
  const ActiveDriverShipmentsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 160.h,
      child: Shimmer.fromColors(
        baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (_, __) => Container(
            width: 280.w,
            margin: EdgeInsetsDirectional.only(end: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
      ),
    );
  }
}
