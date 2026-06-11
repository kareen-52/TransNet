import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import '../../data/models/post_details_model.dart';

class PostCargoCard extends StatelessWidget {
  final PostDetailsModel post;
  const PostCargoCard({super.key, required this.post});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.inventory_2_rounded,
                  color: theme.colorScheme.primary,
                  size: 22.sp,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Text(
                  post.object ?? 'غير محدد',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (post.insurance == 1)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shield_rounded,
                        color: Colors.green,
                        size: 16.sp,
                      ),
                      horizontalSpace(4),
                      Text(
                        'مؤمن',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          verticalSpace(20),


          Row(
            children: [
              Expanded(
                child: _buildDimensionChip(
                  theme,
                  'الوزن',
                  '${post.weight ?? '-'} كغ',
                  Icons.monitor_weight_rounded,
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: _buildDimensionChip(
                  theme,
                  'الطول',
                  '${post.length ?? '-'} سم',
                  Icons.straighten_rounded,
                ),
              ),
            ],
          ),
          verticalSpace(8),
          Row(
            children: [
              Expanded(
                child: _buildDimensionChip(
                  theme,
                  'العرض',
                  '${post.width ?? '-'} سم',
                  Icons.width_full_rounded,
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: _buildDimensionChip(
                  theme,
                  'الارتفاع',
                  '${post.height ?? '-'} سم',
                  Icons.height_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionChip(
    ThemeData theme,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary, size: 16.sp),
              horizontalSpace(6),
              Text(
                label,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          verticalSpace(6),
          Text(
            value,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
