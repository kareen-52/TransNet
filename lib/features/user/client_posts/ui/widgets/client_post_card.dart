import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import '../../data/models/client_post_model.dart';

class ClientPostCard extends StatelessWidget {
  final ClientPostModel post;
  const ClientPostCard({super.key, required this.post});

  String _formatNumber(num number) {
    return number
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFinished = post.finished == 1;
    final statusColor = isFinished ? Colors.green : theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: نوع الغرض + الحالة ──
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.inventory_2_rounded,
                    color: statusColor,
                    size: 20.sp,
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.object ?? 'شحنة غير مسماة',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(4),
                      Text(
                        isFinished
                            ? 'مكتمل - تم التوصيل'
                            : 'مفتوح - بانتظار العروض',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: theme.colorScheme.outline.withOpacity(0.5)),

          // ── Body: المسار (من -> إلى) ──
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // تصميم النقاط والخط الواصل
                Column(
                  children: [
                    Icon(
                      Icons.trip_origin_rounded,
                      color: Colors.green,
                      size: 16.sp,
                    ),
                    Container(
                      width: 2.w,
                      height: 24.h,
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      color: Colors.grey.shade300,
                    ),
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.red,
                      size: 16.sp,
                    ),
                  ],
                ),
                horizontalSpace(12),
                // العناوين
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${post.startGovernorate} - ${post.startLocationDetails}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(22),
                      Text(
                        '${post.endGovernorate} - ${post.endLocationDetails}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Footer: السعر + الموعد ──
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.04),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // الموعد
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 16.sp,
                      color: Colors.grey.shade600,
                    ),
                    horizontalSpace(6),
                    Text(
                      'أقصى موعد: ${post.lastDate ?? 'غير محدد'}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // السعر
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'السعر المقترح',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      '${_formatNumber(post.minPrice ?? 0)} - ${_formatNumber(post.maxPrice ?? 0)}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
