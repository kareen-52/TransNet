import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/shipping_card/scheduled_shipment_button.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/shipping_card/shipping_card_header.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/shipping_card/shipping_submit_button.dart';

class ShippingCard extends StatelessWidget {
  final bool isTablet;
  final VoidCallback onNavigateToAds;

  const ShippingCard({
    super.key,
    required this.isTablet,
    required this.onNavigateToAds,
  });

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
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (isTablet) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: ShippingSubmitButton()),
          horizontalSpace(16),
          Expanded(child: ScheduledShipmentButton(onTap: onNavigateToAds)),
        ],
      );
    }

    return Column(
      children: [
        const ShippingSubmitButton(),
        verticalSpace(10),
        ScheduledShipmentButton(onTap: onNavigateToAds),
      ],
    );
  }
}
