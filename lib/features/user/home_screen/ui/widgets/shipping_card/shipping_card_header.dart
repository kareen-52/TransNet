import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/font_weight_helper.dart';

class ShippingCardHeader extends StatelessWidget {
  const ShippingCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'هل تريد شحن شيء جديد؟',
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        height: 1.2,
                        fontWeight: FontWeightHelper.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.only(right: 48.w),
                      child: Icon(
                        Icons.local_shipping_rounded,
                        color: theme.colorScheme.secondary,
                        size: 80.sp,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(8),
              Text(
                'ابدأ طلب شحن جديد بسهولة وسرعة',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
