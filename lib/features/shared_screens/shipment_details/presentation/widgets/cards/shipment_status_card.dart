import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/card_decoration.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/info_row.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/row_divider.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/utils/date_formatter.dart';

class ShipmentStatusCard extends StatelessWidget {
  final ShipmentEntity shipment;
  final bool isDark;

  const ShipmentStatusCard({
    super.key,
    required this.shipment,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    // final showPaidPill = true;
    // final showSuccessPill = true;
    final showPaidPill = shipment.paid != null;
    final showSuccessPill = shipment.success != null;
    final showPillsRow = showPaidPill || showSuccessPill;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: buildCardDecoration(
        surface: surface,
        border: border,
        isDark: isDark,
      ),
      child: Column(
        children: [
          InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'تاريخ التسليم',
            value: DateFormatter.format(shipment.deliveryDeadline),
            isDark: isDark,
          ),
          RowDivider(isDark: isDark),
          InfoRow(
            icon: Icons.access_time_rounded,
            label: 'تاريخ الإنشاء',
            value: DateFormatter.format(shipment.createdAt),
            isDark: isDark,
          ),
          if (showPillsRow) ...[
            RowDivider(isDark: isDark),
            Row(
              children: [
                if (showPaidPill)
                  Expanded(
                    child: _StatusPill(
                      icon: Icons.payments_outlined,
                      label: shipment.isPaid ? 'مدفوع' : 'غير مدفوع',
                      color: shipment.isPaid
                          ? AppColors.success
                          : AppColors.warning,
                    ),
                  ),
                if (showPaidPill && showSuccessPill) SizedBox(width: 10.w),
                if (showSuccessPill)
                  Expanded(
                    child: _StatusPill(
                      icon: Icons.check_circle_outline_rounded,
                      label: shipment.isCompleted ? 'مكتملة' : 'قيد التنفيذ',
                      color: shipment.isCompleted
                          ? AppColors.success
                          : AppColors.secondary,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatusPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
