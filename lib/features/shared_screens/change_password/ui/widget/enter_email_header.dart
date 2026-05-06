import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';


class EnterEmailHeader extends StatelessWidget {
  const EnterEmailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 130.r,
              height: 130.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.5),
                  width: 8.r,
                ),
              ),
              child: Center(
                child: Container(
                  width: 100.r,
                  height: 100.r,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).colorScheme.secondary.withOpacity(0.05),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.08),
                        blurRadius: 10.r,
                        spreadRadius: 2.r,
                      ),
                    ],
                  ),

                  child: Icon(
                    Icons.lock_reset_rounded,
                    size: 60.r,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 10.r,
              right: 5.r,
              child: Container(
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Icon(
                  Icons.email_outlined,
                  size: 16.r,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(30),
        Text(
          'نسيت كلمة المرور؟',
          style: Theme.of(
            context,
          ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        verticalSpace(12),
        Text(
          'أدخل بريدك الإلكتروني لاستلام كود التحقق\nوإعادة تعيين كلمة المرور',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
      ],
    );
  }
}
