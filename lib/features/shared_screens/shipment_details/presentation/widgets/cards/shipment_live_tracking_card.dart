import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/live_tracking_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/card_decoration.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/info_row.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/row_divider.dart';

class ShipmentLiveTrackingCard extends StatelessWidget {
  final LiveTrackingEntity liveTracking;
  final bool isDark;

  const ShipmentLiveTrackingCard({
    super.key,
    required this.liveTracking,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    if (liveTracking.hasError) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: buildCardDecoration(
          surface: surface,
          border: border,
          isDark: isDark,
        ),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Icon(
                Icons.location_off_outlined,
                size: 16.sp,
                color: secondaryColor,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                liveTracking.error!,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 13.sp, color: secondaryColor),
              ),
            ),
          ],
        ),
      );
    }

    if (!liveTracking.hasData) {
      return const SizedBox.shrink();
    }

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
            icon: Icons.social_distance_outlined,
            label: 'المسافة المتبقية',
            value: '${liveTracking.remainingDistanceKm} كم',
            isDark: isDark,
          ),
          RowDivider(isDark: isDark),
          InfoRow(
            icon: Icons.timer_outlined,
            label: 'الوقت المتبقي',
            value: '${liveTracking.remainingDurationMins} دقيقة',
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}
