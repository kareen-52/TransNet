import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';

class OtpHeader extends StatelessWidget {
  final String email;

  const OtpHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          // width: 80.w,
          // height: 80.h,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,

            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_person_outlined,
            color: theme.colorScheme.primary,
            size: 48,
          ),
        ),
        // const SizedBox(height: 24),
        verticalSpace(24),

        Text('كود التحقق', style: theme.textTheme.displayMedium),

        verticalSpace(12),

        Text.rich(
          TextSpan(
            text: 'أدخل الكود المكون من 6 أرقام المرسل إلى\n',
            style: theme.textTheme.bodyMedium,
            children: [
              TextSpan(
                text: email,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
