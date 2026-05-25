import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PostsShimmer extends StatelessWidget {
  const PostsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.onSurface.withOpacity(0.1),
      highlightColor: theme.colorScheme.onSurfaceVariant.withOpacity(0.2),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 6,
        padding: EdgeInsets.all(16.w),
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (_, __) => Container(
          height: 180.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}
