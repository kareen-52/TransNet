import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PostsShimmer extends StatelessWidget {
  const PostsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Shimmer.fromColors(
      baseColor: theme.colorScheme.onSurface.withOpacity(0.1),
      highlightColor: theme.colorScheme.onSurfaceVariant.withOpacity(0.2),
      child: isTablet
          ? GridView.builder(
              padding: EdgeInsets.only(
                left: 32.w,
                right: 32.w,
                top: 32.h,
                bottom: 16.h,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 16,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,

                childAspectRatio: ((screenWidth - 48.w) / 2) / 180.h,
              ),
              itemBuilder: (_, __) => const _ShimmerCardItem(),
            )
          : Column(
              children: List.generate(5, (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 16.h,
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: const _ShimmerCardItem(),
                );
              }),
            ),
    );
  }
}

class _ShimmerCardItem extends StatelessWidget {
  const _ShimmerCardItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }
}
