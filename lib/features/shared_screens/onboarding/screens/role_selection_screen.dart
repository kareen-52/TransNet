// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:graduation_progect/core/helpers/extensions.dart';
// import 'package:graduation_progect/core/routing/routes.dart';
// import 'package:graduation_progect/features/shared_screens/onboarding/screens/driver_activation_steps_screen.dart';
// import 'package:graduation_progect/features/shared_screens/login/ui/screen/login_screen.dart';
// import '../../../../core/helpers/spacing.dart';
// import '../../../../core/theming/font_weight_helper.dart';
// import '../widgets/role_card.dart';

// class RoleSelectionScreen extends StatelessWidget {
//   const RoleSelectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               verticalSpace(70),
//               Text(
//                 'ابدأ رحلتك باختيار دورك',
//                 style: Theme.of(context).textTheme.displayMedium,
//               ),
//               verticalSpace(50),

//               RoleCard(
//                 title: 'أريد شحن بضاعة',
//                 backgroundColor: Theme.of(context).colorScheme.primary,

//                 imagePath: 'assets/images/box.png',
//                 onTap: () {
//                   context.pushReplacementNamed(Routes.login);
//                 },
//               ),

//               verticalSpace(30),

//               RoleCard(
//                 title: 'أريد العمل كسائق',
//                 backgroundColor: Theme.of(context).colorScheme.secondary,

//                 imagePath: 'assets/images/delivery_van.png',
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const DriverActivationStepsScreen(),
//                     ),
//                   );
//                 },
//               ),
//               const Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'لديك حساب بالفعل؟',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       context.pushReplacementNamed(Routes.login);
//                     },
//                     child: Text(
//                       'تسجيل الدخول ',
//                       style: Theme.of(context).textTheme.labelMedium?.copyWith(
//                         color: Theme.of(context).colorScheme.secondary,
//                         fontWeight: FontWeightHelper.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
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
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/responsive/responsive_layout.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/features/shared_screens/onboarding/screens/driver_activation_steps_screen.dart';
import '../widgets/role_card.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isTablet
        ? const _TabletRoleSelection()
        : const _MobileRoleSelection();
  }
}


class _MobileRoleSelection extends StatelessWidget {
  const _MobileRoleSelection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(70),
              Text(
                'ابدأ رحلتك باختيار دورك',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              verticalSpace(50),
              RoleCard(
                title: 'أريد شحن بضاعة',
                backgroundColor: Theme.of(context).colorScheme.primary,
                imagePath: 'assets/images/box.png',
                onTap: () => context.pushReplacementNamed(Routes.login),
              ),
              verticalSpace(30),
              RoleCard(
                title: 'أريد العمل كسائق',
                backgroundColor: Theme.of(context).colorScheme.secondary,
                imagePath: 'assets/images/delivery_van.png',
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DriverActivationStepsScreen(),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لديك حساب بالفعل؟',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () => context.pushReplacementNamed(Routes.login),
                    child: Text(
                      'تسجيل الدخول ',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeightHelper.bold,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}


class _TabletRoleSelection extends StatelessWidget {
  const _TabletRoleSelection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 48.h),
            child: TabletFormContainer(
              maxWidth: 680,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(24),
                  Text(
                    'ابدأ رحلتك باختيار دورك',
                    style: theme.textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(48),
            
                  Row(
                    children: [
                      Expanded(
                        child: RoleCard(
                          title: 'أريد شحن بضاعة',
                          backgroundColor: theme.colorScheme.primary,
                          imagePath: 'assets/images/box.png',
                          onTap: () =>
                              context.pushReplacementNamed(Routes.login),
                        ),
                      ),
                      horizontalSpace(24),
                      Expanded(
                        child: RoleCard(
                          title: 'أريد العمل كسائق',
                          backgroundColor: theme.colorScheme.secondary,
                          imagePath: 'assets/images/delivery_van.png',
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DriverActivationStepsScreen(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لديك حساب بالفعل؟',
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () =>
                            context.pushReplacementNamed(Routes.login),
                        child: Text(
                          'تسجيل الدخول ',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeightHelper.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
