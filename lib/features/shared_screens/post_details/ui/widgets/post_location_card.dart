import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import '../../data/models/post_details_model.dart';

class PostLocationsCard extends StatelessWidget {
  final PostDetailsModel post;
  const PostLocationsCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLocationRow(
            context,
            icon: Icons.trip_origin_rounded,
            iconColor: Colors.green,
            title: 'نقطة الانطلاق',
            governorate: post.startGovernorate ?? 'غير محدد',
            details: post.startLocationDetails ?? 'غير محدد',
          ),
          verticalSpace(12),
          Divider(color: theme.colorScheme.outline.withOpacity(0.25)),
          verticalSpace(12),

          _buildLocationRow(
            context,
            icon: Icons.location_on_rounded,
            iconColor: theme.colorScheme.error,
            title: 'نقطة الوصول',
            governorate: post.endGovernorate ?? 'غير محدد',
            details: post.endLocationDetails ?? 'غير محدد',
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String governorate,
    required String details,
  }) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: iconColor, size: 20.sp),
        ),
        horizontalSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              verticalSpace(4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  governorate,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              verticalSpace(4),
              Text(
                details,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
