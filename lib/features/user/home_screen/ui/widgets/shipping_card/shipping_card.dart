import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/shipping_card/shipping_card_header.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/shipping_card/shipping_submit_button.dart';


class ShippingCard extends StatelessWidget {
  const ShippingCard({super.key,});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: theme.colorScheme.secondary, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.secondary.withOpacity(0.3),
            blurRadius: 5.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShippingCardHeader(),
          verticalSpace(24),
          const ShippingSubmitButton(),
        ],
      ),
    );
  }
}
