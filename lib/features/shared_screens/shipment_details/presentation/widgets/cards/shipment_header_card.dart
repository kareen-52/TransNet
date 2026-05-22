import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/card_decoration.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/copy_chip.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/status_badge.dart';

/// Hero card displayed at the top of the screen.
///
/// Shows the shipment icon, number, status badge and an inline
/// [CopyChip] so the tracking number is always one tap away.
class ShipmentHeaderCard extends StatelessWidget {
  final ShipmentEntity shipment;
  final bool isDark;

  const ShipmentHeaderCard({
    super.key,
    required this.shipment,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor =
        shipment.isCompleted ? AppColors.success : AppColors.secondary;
    final surface =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: buildCardDecoration(
          surface: surface, border: border, isDark: isDark),
      child: Row(
        children: [
          _ShipmentIcon(color: statusColor),
          SizedBox(width: 14.w),
          Expanded(
            child: _ShipmentInfo(
                shipment: shipment, statusColor: statusColor, context: context),
          ),
          CopyChip(
            value: shipment.shipmentNumber.toString(),
            label: 'نسخ الرقم',
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _ShipmentIcon extends StatelessWidget {
  final Color color;
  const _ShipmentIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(Icons.local_shipping_rounded, color: color, size: 26.sp),
    );
  }
}

class _ShipmentInfo extends StatelessWidget {
  final ShipmentEntity shipment;
  final Color statusColor;
  final BuildContext context;

  const _ShipmentInfo({
    required this.shipment,
    required this.statusColor,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'شحنة #${shipment.shipmentNumber}',
          style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
        ),
        SizedBox(height: 6.h),
        StatusBadge(
          label: shipment.displayStatus,
          color: statusColor,
        ),
      ],
    );
  }
}
