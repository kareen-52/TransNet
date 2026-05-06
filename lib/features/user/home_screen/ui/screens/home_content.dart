import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/active_orders_section/active_orders_section.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/shipping_card/shipping_card.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/tracking_card.dart';
import 'package:graduation_progect/features/user/vehicle_types.dart/ui/screens/transport_types_section.dart';

class HomeContent extends StatelessWidget {
  final bool isTablet;
  const HomeContent({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 56.w : 16.w,
          vertical: isTablet ? 32.h : 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isTablet
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: ShippingCard(),
                      ),
                      horizontalSpace(24),
                      const Expanded(child: TrackingCard()),
                    ],
                  )
                : const ShippingCard(),

            verticalSpace(isTablet ? 40 : 32),

            const ActiveOrdersSection(),

            verticalSpace(isTablet ? 40 : 32),

            const TransportMethodsSection(),
          ],
        ),
      ),
    );
  }
}
