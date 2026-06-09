import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/widgets/badge/badge_ui_helper.dart';
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
      margin: EdgeInsets.only(bottom: 12.h),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver.fullName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: AppColors.warning,
                          size: 16.sp,
                        ),
                        horizontalSpace(4),
                        Text(
                          driver.rating?.toStringAsFixed(1) ?? 'جديد',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        horizontalSpace(8),
                        Container(
                          width: 4.w,
                          height: 4.w,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                        ),
                        horizontalSpace(8),
                        Text(
                          driver.vehicle ?? 'غير محدد',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'السعر',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    driver.formattedPrice,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),


          if (driver.badge != null && driver.badge!.isNotEmpty) ...[
            verticalSpace(12),
            _buildBadgeWithHelper(theme, driver),
          ],


          if (driver.date != null || (!isFinished && isClient)) ...[
            verticalSpace(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                if (driver.date != null)
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.event_rounded,
                          color: theme.colorScheme.onSurface,
                          size: 16.sp,
                        ),
                        horizontalSpace(6),
                        Expanded(
                          child: Text(
                            'تاريخ العرض: ${driver.date}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const Spacer(),


                if (!isFinished && isClient) ...[
                  horizontalSpace(12),
                  AppTextButton(
                    width:
                        135,
                    height: 40,
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
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBadgeWithHelper(ThemeData theme, PostDriverOfferModel driver) {
    final badgeColor = BadgeUiHelper.getBadgeColor(driver.badge!);
    final badgeIconPath = BadgeUiHelper.getBadgeIconPath(driver.badge!);

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: badgeColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: badgeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Image.asset(
              badgeIconPath,
              width: 18.w,
              height: 18.w,
              fit: BoxFit.contain,
            ),
          ),
          horizontalSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driver.badge ?? '',
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (driver.badgeText != null) ...[
                  verticalSpace(2),
                  Text(
                    driver.badgeText!,
                    style: TextStyle(
                      color: badgeColor.withOpacity(0.8),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
