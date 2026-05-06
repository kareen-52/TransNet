import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                horizontalSpace(8),
                Text(
                  'قيد التنفيذ',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            verticalSpace(8),
            Text(
              'طلب #29384',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeightHelper.bold,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              Text('الوقت المتوقع', style: theme.textTheme.bodySmall),
              verticalSpace(4),
              Text(
                '14:30',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
