import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/features/shared_screens/onboarding/screens/driver_activation_steps_screen.dart';
import 'package:graduation_progect/features/shared_screens/login/ui/screen/login_screen.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/font_weight_helper.dart';
import '../widgets/role_card.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

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
                onTap: () {
                  context.pushReplacementNamed(Routes.login);
                },
              ),

              verticalSpace(30),

              RoleCard(
                title: 'أريد العمل كسائق',
                backgroundColor: Theme.of(context).colorScheme.secondary,

                imagePath: 'assets/images/delivery_van.png',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DriverActivationStepsScreen(),
                    ),
                  );
                },
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
                    onPressed: () {
                      context.pushReplacementNamed(Routes.login);
                    },
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
