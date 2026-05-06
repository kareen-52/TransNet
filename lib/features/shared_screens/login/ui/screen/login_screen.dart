import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/shared_screens/login/ui/widget/dont_have_account_text.dart';
import 'package:graduation_progect/features/shared_screens/login/ui/widget/login_form.dart';
import 'package:graduation_progect/features/shared_screens/login/ui/widget/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const LoginHeader(),
              verticalSpace(32),
              const LoginForm(),
              verticalSpace(24),
              const DontHaveAccountText(),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
