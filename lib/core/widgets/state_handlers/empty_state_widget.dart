import 'package:flutter/material.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../helpers/animation_constants.dart';
import '../../helpers/spacing.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final VoidCallback? onRetry;
  const EmptyStateWidget({
    super.key,
    required this.title,
    this.subTitle,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(AnimationConstants.emptyState, width: 200.w),
            verticalSpace(48),
            Text(
              title,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (subTitle != null) ...[
              verticalSpace(16),
              Text(
                subTitle!,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              verticalSpace(24),
              AppTextButton(
                text: 'إعادة المحاولة',
                backgroundColor: Theme.of(context).colorScheme.secondary,
                prefixIcon: const Icon(Icons.refresh),
                onPressed: onRetry,
              ),
              verticalSpace(88),
            ],
          ],
        ),
      ),
    );
  }
}
