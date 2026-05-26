import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/glass_icon_button.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/share/share_service.dart';

class ShipmentAppBar extends StatelessWidget {
  final ShipmentDetailsEntity data;
  final bool isDark;

  const ShipmentAppBar({
    super.key,
    required this.data,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final shipment = data.shipment;
    final statusColor =
        shipment.isCompleted ? AppColors.success : AppColors.secondary;
    final bgColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      snap: true,
      pinned: true,
      backgroundColor: bgColor,
      elevation: 0,
      scrolledUnderElevation: 0.6,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      leading: Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: GlassIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          isDark: isDark,
          onTap: () => Navigator.pop(context),
        ),
      ),
      title: _AppBarTitle(
        shipment: data.shipment,
        statusColor: statusColor,
      ),
      actions: [
        GlassIconButton(
          icon: Icons.share_rounded,
          isDark: isDark,
          onTap: () => ShareService.shareShipmentDetails(context, data),
        ),
        SizedBox(width: 12.w),
      ],
    );
  }
}

// ─── Private title widget ──────────────────────────────────────────────────────

class _AppBarTitle extends StatelessWidget {
  final dynamic shipment; // ShipmentEntity
  final Color statusColor;

  const _AppBarTitle({
    required this.shipment,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'تفاصيل الشحنة',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              shipment.displayStatus,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
