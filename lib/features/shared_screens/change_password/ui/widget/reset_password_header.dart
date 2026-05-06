import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';

class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_reset_rounded,
            size: 40.r,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        verticalSpace(30),
        Text(
          'تعيين كلمة مرور جديدة',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeightHelper.bold,
          ),
        ),
        verticalSpace(12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'يرجى إدخال كلمة المرور الجديدة. تأكد من استخدام كلمة مرور قوية',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(height: 1.5.h),
          ),
        ),
      ],
    );
  }
}
