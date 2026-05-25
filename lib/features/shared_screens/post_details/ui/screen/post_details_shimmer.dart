import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:shimmer/shimmer.dart';

class PostDetailsShimmer extends StatelessWidget {
  const PostDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Shimmer.fromColors(
      baseColor: theme.colorScheme.onSurface.withOpacity(0.1),
      highlightColor: theme.colorScheme.onSurfaceVariant.withOpacity(0.2),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Banner Shimmer
            _buildStatusBannerShimmer(context),
            verticalSpace(24),

            // Section Title Shimmer
            _buildSectionTitleShimmer(context),
            verticalSpace(8),
            // Cargo Card Shimmer
            _buildCargoCardShimmer(context),
            verticalSpace(24),

            // Section Title Shimmer
            _buildSectionTitleShimmer(context),
            verticalSpace(8),
            // Locations Card Shimmer
            _buildLocationsCardShimmer(context),
            verticalSpace(24),

            // Section Title Shimmer
            _buildSectionTitleShimmer(context),
            verticalSpace(8),
            // Price Info Card Shimmer
            _buildPriceInfoCardShimmer(context),
            verticalSpace(32),

            // Drivers Section Header Shimmer
            _buildDriversSectionHeaderShimmer(context),
            verticalSpace(12),
            // Driver Cards Shimmer
            _buildDriverCardShimmer(context),
            verticalSpace(12),
            _buildDriverCardShimmer(context),
            verticalSpace(12),
            _buildDriverCardShimmer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBannerShimmer(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 80.w, height: 12.h, color: Colors.white),
                verticalSpace(6),
                Container(width: 140.w, height: 16.h, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitleShimmer(BuildContext context) {
    return Container(
      width: 120.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _buildCargoCardShimmer(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Container(height: 18.h, color: Colors.white),
              ),
              Container(
                width: 70.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ],
          ),
          verticalSpace(20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 65.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: Container(
                  height: 65.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 65.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: Container(
                  height: 65.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsCardShimmer(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 80.w, height: 12.h, color: Colors.white),
                    verticalSpace(6),
                    Container(width: 100.w, height: 20.h, color: Colors.white),
                    verticalSpace(4),
                    Container(
                      width: double.infinity,
                      height: 16.h,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Center(
            child: Container(width: 2.w, height: 30.h, color: Colors.white),
          ),
          verticalSpace(12),
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 80.w, height: 12.h, color: Colors.white),
                    verticalSpace(6),
                    Container(width: 100.w, height: 20.h, color: Colors.white),
                    verticalSpace(4),
                    Container(
                      width: double.infinity,
                      height: 16.h,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfoCardShimmer(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 60.w, height: 12.h, color: Colors.white),
                    verticalSpace(6),
                    Container(width: 180.w, height: 20.h, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(16),
          Container(height: 1.h, color: Colors.white),
          verticalSpace(16),
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 80.w, height: 12.h, color: Colors.white),
                    verticalSpace(6),
                    Container(width: 130.w, height: 20.h, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDriversSectionHeaderShimmer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: 100.w, height: 20.h, color: Colors.white),
        Container(
          width: 80.w,
          height: 28.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ],
    );
  }

  Widget _buildDriverCardShimmer(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 120.w,
                          height: 16.h,
                          color: Colors.white,
                        ),
                        horizontalSpace(8),
                        Container(
                          width: 80.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(8),
                    Row(
                      children: [
                        Container(
                          width: 80.w,
                          height: 14.h,
                          color: Colors.white,
                        ),
                        horizontalSpace(8),
                        Container(
                          width: 4.w,
                          height: 4.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        horizontalSpace(8),
                        Container(
                          width: 60.w,
                          height: 14.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(width: 40.w, height: 10.h, color: Colors.white),
                  verticalSpace(4),
                  Container(width: 90.w, height: 18.h, color: Colors.white),
                ],
              ),
            ],
          ),
          verticalSpace(12),
          Container(width: double.infinity, height: 14.h, color: Colors.white),
          verticalSpace(16),
          Container(
            width: double.infinity,
            height: 44.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ],
      ),
    );
  }
}
