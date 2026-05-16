import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ActiveDriverShipmentsShimmer extends StatelessWidget {
  const ActiveDriverShipmentsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 160.h,
      child: Shimmer.fromColors(
        baseColor: theme.colorScheme.onSurface.withOpacity(0.1),
        highlightColor: theme.colorScheme.onSurfaceVariant.withOpacity(0.2),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
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
