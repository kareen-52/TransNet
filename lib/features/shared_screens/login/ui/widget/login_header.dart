import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        verticalSpace(70),
        Center(
          child: SizedBox(
            width: 140.w,
            height: 140.h,

            child: Image.asset('assets/icons/logo.png'),
          ),
        ),
        verticalSpace(40),
        Text('مرحباً بك مجدداً', style: theme.textTheme.displayMedium),
        verticalSpace(12),
        Text(
          'قم بتسجيل الدخول لمتابعة شحناتك وإدارة طلباتك',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
