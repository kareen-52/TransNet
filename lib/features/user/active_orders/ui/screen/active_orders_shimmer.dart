import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:shimmer/shimmer.dart';

class ActiveOrdersShimmer extends StatelessWidget {
  const ActiveOrdersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 250.h,
      child: Shimmer.fromColors(
        baseColor: theme.colorScheme.onSurface.withOpacity(0.1),
        highlightColor: theme.colorScheme.onSurfaceVariant.withOpacity(0.2),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: 5,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => horizontalSpace(16),
          itemBuilder: (_, __) => Container(
            width: 290.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
        ),
      ),
    );
  }
}
