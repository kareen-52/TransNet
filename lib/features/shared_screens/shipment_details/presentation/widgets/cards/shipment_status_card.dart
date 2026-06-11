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

            RowDivider(isDark: isDark),
           
        ],
      ),
    );
  }
}
