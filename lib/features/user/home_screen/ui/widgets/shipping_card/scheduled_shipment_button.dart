import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';

class ScheduledShipmentButton extends StatelessWidget {
  final VoidCallback onTap;

  const ScheduledShipmentButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppTextButton(
      text: 'طلب شحن مجدول (إعلان)',
      height: 48,
      backgroundColor: theme.colorScheme.secondary.withOpacity(0.08),
      borderSide: BorderSide(
        color: theme.colorScheme.secondary.withOpacity(0.35),
        width: 1.w,
      ),
      borderRadius: 16.0,
      textStyle: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.secondary,
        fontWeight: FontWeightHelper.semiBold,
      ),
      prefixIcon: Icon(
        Icons.campaign_outlined,
        size: 18.sp,
        color: theme.colorScheme.secondary,
      ),
      onPressed: onTap,
    );
  }
}
