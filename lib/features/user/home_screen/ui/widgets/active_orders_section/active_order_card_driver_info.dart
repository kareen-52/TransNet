import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/user_avatar.dart';

class DriverInfo extends StatelessWidget {
  const DriverInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UserAvatar(radius: 24.r, imageUrl: 'https://i.pravatar.cc/150?img=12'),
        horizontalSpace(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tooltip(
                message: 'محمد عبدالله الغامدي بن فلان',
                triggerMode: TooltipTriggerMode.tap,
                preferBelow: false,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                textStyle: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.surface,
                ),
                child: Text(
                  'محمد عبدالله الغامدي بن فلان',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeightHelper.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              verticalSpace(4),
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.warning, size: 18.r),
                  horizontalSpace(4),
                  Text('4.9'),
                ],
              ),
            ],
          ),
        ),
        horizontalSpace(8),
        Expanded(
          child: AppTextButton(
            text: 'اتصال',
            width: 110.w,
            height: 48.h,
            backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
            textStyle: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeightHelper.bold,
            ),
            prefixIcon: Icon(
              Icons.phone_outlined,
              color: theme.colorScheme.secondary,
              size: 22.sp,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
