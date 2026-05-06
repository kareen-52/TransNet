import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/features/user/home_screen/ui/screens/home_entities.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/active_orders_section/active_order_card_driver_info.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/active_orders_section/active_order_card_timeline.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/active_orders_section/active_order_card_header.dart';
import 'active_order_card.dart';

class ActiveOrdersSection extends StatelessWidget {
  const ActiveOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('الطلبات النشطة', style: theme.textTheme.titleMedium),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Text(
                '1 طلب نشط',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeightHelper.bold,
                  // fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),

        verticalSpace(8),

        ActiveOrderCard(
          header: OrderHeader(),
          timeline: OrderTimeline(
            steps: [
              TimelineStepModel(label: 'تم الإرسال', isDone: true),
              TimelineStepModel(label: 'تم القبول', isDone: true),
              TimelineStepModel(label: 'في الطريق', isActive: true),
              TimelineStepModel(label: 'تم التسليم'),
            ],
          ),
          footer: DriverInfo(),
        ),
      ],
    );
  }
}
