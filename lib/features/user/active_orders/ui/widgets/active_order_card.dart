import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/ui/screens/shipment_details_screen.dart';
import 'package:graduation_progect/features/user/active_orders/ui/widgets/driver_info_row.dart';
import 'package:graduation_progect/features/user/active_orders/ui/widgets/order_header.dart';
import 'package:graduation_progect/features/user/active_orders/ui/widgets/order_price_row.dart';
import 'package:graduation_progect/features/user/active_orders/ui/widgets/order_progress_tracker.dart';
import '../../data/models/active_order_model.dart';

class ActiveOrderCard extends StatelessWidget {
  final ActiveOrderModel order;
  const ActiveOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(24.r),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ShipmentDetailsScreen(shipmentId: order.id),
          ),
        );
      },
      child: Container(
        width: 290.w,
        // height: 300.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              OrderHeader(
                status: order.status,
                shipmentNumber: order.shipmentNumber,
              ),
              verticalSpace(24),

              OrderProgressTracker(status: order.status),
              verticalSpace(24),

              Divider(color: theme.dividerColor.withOpacity(0.5), height: 1),
              verticalSpace(16),

              OrderPriceRow(price: order.price),
              verticalSpace(24),

              Flexible(child: DriverInfoRow(driver: order.driver)),
            ],
          ),
        ),
      ),
    );
  }
}
