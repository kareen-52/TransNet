import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/post_model.dart';

class DriverPostCard extends StatelessWidget {
  final PostModel post;

  const DriverPostCard({super.key, required this.post});

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

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.postDetailsScreen,
          arguments: post.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.15),
          ),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── 1. العنوان والغرض ──
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: Text(
                      post.object ?? 'شحنة غير مسماة',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            Divider(
              height: 1,
              color: theme.colorScheme.outline.withOpacity(0.3),
            ),

            // ── 2. المسار ──
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.trip_origin_rounded,
                        color: Colors.green,
                        size: 16.sp,
                      ),
                      Container(
                        width: 2.w,
                        height: 28.h,
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        color: Colors.grey.shade300,
                      ),
                      Icon(
                        Icons.location_on_rounded,
                        color: theme.colorScheme.error,
                        size: 16.sp,
                      ),
                    ],
                  ),
                  horizontalSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${post.startGovernorate ?? 'غير محدد'} - ${post.startLocationDetails ?? ''}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpace(26),
                        Text(
                          '${post.endGovernorate ?? 'غير محدد'} - ${post.endLocationDetails ?? ''}',
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

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.04),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // تم التعديل هنا: استخدام Expanded وإزالة mainAxisSize: MainAxisSize.min لمنع أخطاء الـ RenderFlex
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              size: 16.sp,
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                            horizontalSpace(6),
                            Expanded(
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'أقصى موعد:\n',
                                      style: TextStyle(
                                        color: theme.colorScheme.onSurface
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                    TextSpan(
                                      text: post.lastDate ?? 'غير محدد',
                                      style: TextStyle(
                                        color: theme.colorScheme.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      horizontalSpace(8),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'نطاق السعر المقترح',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${_formatNumber(post.minPrice ?? 0)} - ${_formatNumber(post.maxPrice ?? 0)}',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(16),
                  AppTextButton(
                    text: 'عرض التفاصيل وتقديم عرض',
                    height: 48.h,
                    textStyle: TextStyle(
                      fontSize: 13.sp,
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.postDetailsScreen,
                        arguments: post.id,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}