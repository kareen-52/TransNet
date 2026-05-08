import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import '../../data/models/vehicle_type_model.dart';

class VehicleDetailsBottomSheet extends StatelessWidget {
  final VehicleTypeModel vehicle;
  final IconData icon;
  final Color color;

  const VehicleDetailsBottomSheet({
    super.key,
    required this.vehicle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      // width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.outline,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          verticalSpace(24),

          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32.sp),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.type,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeightHelper.bold,
                      ),
                    ),
                    Text(
                      'الأجرة الأساسية: ${double.parse(vehicle.baseFare).round()} ل.س',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeightHelper.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(24),

          Text(
            vehicle.description,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.start,
          ),
          verticalSpace(24),

          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  context,
                  Icons.scale,
                  'الوزن المسموح',
                  'حتى ${double.parse(vehicle.maxWeight).round()} كغ',
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: _buildInfoChip(
                  context,
                  Icons.aspect_ratio,
                  'أقصى طول',
                  '${double.parse(vehicle.maxLength).round()} سم',
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  context,
                  Icons.height,
                  'أقصى ارتفاع',
                  '${double.parse(vehicle.maxHeight).round()} سم',
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: _buildInfoChip(
                  context,
                  Icons.width_full,
                  'أقصى عرض',
                  '${double.parse(vehicle.maxWidth).round()} سم',
                ),
              ),
            ],
          ),
          verticalSpace(56),

          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: () => Navigator.pop(context),
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: theme.colorScheme.primary,
          //       padding: EdgeInsets.symmetric(vertical: 14.h),
          //     ),
          //     child: Text(
          //       'حسناً، فهمت',
          //       style: theme.textTheme.titleMedium?.copyWith(
          //         color: Colors.white,
          //         fontWeight: FontWeightHelper.bold,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24.sp),
          verticalSpace(8),
          Text(title, style: theme.textTheme.bodySmall),
          verticalSpace(4),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeightHelper.bold,
            ),
          ),
        ],
      ),
    );
  }
}
