import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(30),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'مرحباً بك في ',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontSize: 22),
              ),
              TextSpan(
                text: 'ترانسنيت ',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  height: 1.5,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(8),
        Text(
          'يرجى إدخال بياناتك لإنشاء حساب جديد',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
        ),
      ],
    );
  }
}
