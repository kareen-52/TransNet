import 'package:flutter/material.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../helpers/animation_constants.dart';
import '../../helpers/spacing.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AnimationConstants.errorState,
              fit: BoxFit.contain,
              width: 150.w,
              height: 150.h,
            ),
            verticalSpace(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalSpace(16),
            AppTextButton(
              text: 'إعادة المحاولة',
              backgroundColor: Theme.of(context).colorScheme.secondary,
              prefixIcon: const Icon(Icons.refresh),
              onPressed: onRetry,
            ),
            // verticalSpace(88),
          ],
        ),
      ),
    );
  }
}
