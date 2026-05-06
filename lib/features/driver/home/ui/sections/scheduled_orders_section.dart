import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../widgets/scheduled_order_card.dart';

class ScheduledOrdersSection extends StatelessWidget {
  const ScheduledOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الطلبات المجدولة',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.tune,
                size: 20.sp,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),

        verticalSpace(16),

        isTablet
            ? GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 1.2,
                children: [
                  ScheduledOrderCard(
                    price: '25,000 ل.س',
                    date: '18 أيلول',
                    from: 'دمشق - المزة',
                    to: 'جرمانا',
                    onTap: () {},
                  ),
                  ScheduledOrderCard(
                    price: '18,500 ل.س',
                    date: '26 نيسان',
                    from: 'ريف دمشق - قدسيا',
                    to: 'البرامكة',
                    onTap: () {},
                  ),
                  ScheduledOrderCard(
                    price: '22,000 ل.س',
                    date: '30 نيسان',
                    from: 'دمشق - كفرسوسة',
                    to: 'دوما',
                    onTap: () {},
                  ),
                ],
              )
            : Column(
                children: [
                  ScheduledOrderCard(
                    price: '25,000 ل.س',
                    date: '18 أيلول',
                    from: 'دمشق - المزة',
                    to: 'جرمانا',
                    onTap: () {},
                  ),
                  verticalSpace(16),
                  ScheduledOrderCard(
                    price: '18,500 ل.س',
                    date: '26 نيسان',
                    from: 'ريف دمشق - قدسيا',
                    to: 'البرامكة',
                    onTap: () {},
                  ),
                  verticalSpace(32),
                ],
              ),
      ],
    );
  }
}
