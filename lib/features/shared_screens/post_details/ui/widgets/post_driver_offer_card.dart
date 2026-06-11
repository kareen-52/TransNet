import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/widgets/badge/driver_badge_widget.dart';
import '../../data/models/post_details_model.dart';

class PostDriverOfferCard extends StatelessWidget {
  final PostDriverOfferModel driver;
  final bool isFinished;
  final bool isClient;
  final bool isLoading;
  final VoidCallback? onAccept;

  const PostDriverOfferCard({
    super.key,
    required this.driver,
    required this.isFinished,
    required this.isClient,
    this.isLoading = false,
    this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver.fullName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(6),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: AppColors.warning,
                          size: 18.sp,
                        ),
                        horizontalSpace(4),
                        Text(
                          driver.rating?.toStringAsFixed(1) ?? 'جديد',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (driver.badge != null && driver.badge!.isNotEmpty) ...[
                horizontalSpace(12),
                DriverBadgeWidget(
                  badgeTitle: driver.badge!,
                  badgeDescription:
                      driver.badgeText ?? 'لا يوجد وصف إضافي لهذا الوسام.',
                ),
              ],
            ],
          ),

          verticalSpace(16),

          Row(
            children: [
              Text(
                "وسيلة النقل:",

                style: TextStyle(
                  fontSize: 14.sp,
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
              horizontalSpace(6),
              Text(
                driver.vehicle ?? 'غير محدد',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),

          verticalSpace(16),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.08),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'قيمة العرض',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        driver.formattedPrice,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 1.w,
                  height: 32.h,
                  color: theme.colorScheme.outline.withOpacity(0.2),
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تاريخ العرض',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        driver.date ?? 'غير محدد',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14.sp,
                          color: theme.colorScheme.secondary,
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

          if (!isFinished && isClient) ...[
            verticalSpace(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppTextButton(
                  width: 130.w,
                  height: 40.h,
                  text: 'قبول العرض',
                  backgroundColor: theme.colorScheme.secondary,
                  textStyle: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  isLoading: isLoading,
                  onPressed: onAccept,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
