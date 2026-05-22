import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/info_row.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/row_divider.dart';

/// Body section of the cargo card — object type, weight and dimensions.
class CargoDetailsBody extends StatelessWidget {
  final ShipmentEntity shipment;
  final bool isDark;

  const CargoDetailsBody({
    super.key,
    required this.shipment,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          if (shipment.object != null) ...[
            InfoRow(
              icon: Icons.inventory_2_outlined,
              label: 'نوع المحمول',
              value: shipment.object!,
              isDark: isDark,
            ),
            RowDivider(isDark: isDark),
          ],
          if (shipment.weight != null) ...[
            InfoRow(
              icon: Icons.scale_outlined,
              label: 'الوزن',
              value: '${shipment.weight} كغم',
              isDark: isDark,
            ),
            if (shipment.hasDimensions) RowDivider(isDark: isDark),
          ],
          if (shipment.hasDimensions)
            _DimensionsBlock(shipment: shipment, isDark: isDark),
        ],
      ),
    );
  }
}

class _DimensionsBlock extends StatelessWidget {
  final ShipmentEntity shipment;
  final bool isDark;

  const _DimensionsBlock({required this.shipment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final secondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
              child: Icon(Icons.straighten_rounded,
                  size: 16.sp, color: secondary),
            ),
            SizedBox(width: 12.w),
            Text('الأبعاد',
                style: TextStyle(fontSize: 13.sp, color: secondary)),
          ],
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            if (shipment.width != null)
              _DimChip(
                  label: 'عرض',
                  value: '${shipment.width} سم',
                  isDark: isDark),
            if (shipment.height != null)
              _DimChip(
                  label: 'ارتفاع',
                  value: '${shipment.height} سم',
                  isDark: isDark),
            if (shipment.length != null)
              _DimChip(
                  label: 'طول',
                  value: '${shipment.length} سم',
                  isDark: isDark),
          ],
        ),
      ],
    );
  }
}

class _DimChip extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const _DimChip(
      {required this.label, required this.value, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primary.withValues(alpha: 0.12)
            : AppColors.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.20)),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label  ',
              style: TextStyle(
                fontSize: 10.sp,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
