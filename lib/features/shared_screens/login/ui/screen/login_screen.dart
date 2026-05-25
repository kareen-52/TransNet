// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:graduation_progect/core/helpers/spacing.dart';
// import 'package:graduation_progect/features/shared_screens/login/ui/widget/dont_have_account_text.dart';
// import 'package:graduation_progect/features/shared_screens/login/ui/widget/login_form.dart';
// import 'package:graduation_progect/features/shared_screens/login/ui/widget/login_header.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Column(
//             children: [
//               const LoginHeader(),
//               verticalSpace(32),
//               const LoginForm(),
//               verticalSpace(24),
//               const DontHaveAccountText(),
//               verticalSpace(20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/responsive/responsive_layout.dart';
import 'package:graduation_progect/features/shared_screens/login/ui/widget/dont_have_account_text.dart';
import 'package:graduation_progect/features/shared_screens/login/ui/widget/login_form.dart';
import 'package:graduation_progect/features/shared_screens/login/ui/widget/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = context.isTablet;

    return Scaffold(
      body: SafeArea(
        child: isTablet ? _TabletLoginLayout() : _MobileLoginLayout(),
      ),
    );
  }
}


class _MobileLoginLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}


class _TabletLoginLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.h),
        child: TabletFormContainer(
          maxWidth: 560,
          child: Column(
            children: [
              verticalSpace(24),
              const LoginHeader(),
              verticalSpace(40),
              const LoginForm(),
              verticalSpace(32),
              const DontHaveAccountText(),
              verticalSpace(24),
            ],
          ),
        ),
      ),
    );
  }
}
