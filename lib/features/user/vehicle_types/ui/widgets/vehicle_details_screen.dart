import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/user/vehicle_types/data/models/vehicle_type_model.dart';
import 'package:graduation_progect/features/user/vehicle_types/ui/widgets/vehicle_ui_helper.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final VehicleTypeModel vehicle;

  const VehicleDetailsScreen({super.key, required this.vehicle});


  String _formatVal(String value) {
    final double? val = double.tryParse(value);
    if (val == null) return value;
    return val == val.truncateToDouble()
        ? val.toInt().toString()
        : val.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    

    final icon = VehicleUiHelper.getIconForVehicle(vehicle.type);
    final color = VehicleUiHelper.getColorForVehicle(vehicle.type);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('تفاصيل وسيلة النقل'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 36.sp),
                ),
                horizontalSpace(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle.type,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace(6),
                      Text(
                        'الأجرة الأساسية: ${_formatVal(vehicle.baseFare)} ل.س',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpace(32),


            Text(
              'عن المركبة',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            verticalSpace(8),
            Text(
              vehicle.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color: theme.colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            verticalSpace(32),


            Text(
              'معلومات التسعير والوقود',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            verticalSpace(12),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: theme.colorScheme.primary.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTechSpec(
                    context,
                    title: 'الأجرة الأساسية',
                    value: '${_formatVal(vehicle.baseFare)} ل.س',
                    icon: Icons.payments_rounded,
                  ),
                  _buildTechSpec(
                    context,
                    title: 'استهلاك الوقود',
                    value: '${_formatVal(vehicle.avgFuelConsumption)} لتر/100كم',
                    icon: Icons.local_gas_station_rounded,
                  ),
                  _buildTechSpec(
                    context,
                    title: 'معامل المركبة',
                    value: 'x ${_formatVal(vehicle.vehicleCoefficient)}',
                    icon: Icons.calculate_rounded,
                  ),
                ],
              ),
            ),
            verticalSpace(32),


            Text(
              'الأبعاد والسعة المسموحة',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            verticalSpace(12),
            Row(
              children: [
                Expanded(
                  child: _buildInfoChip(
                    context,
                    icon: Icons.scale_rounded,
                    title: 'الوزن',
                    value: '${_formatVal(vehicle.minWeight)} - ${_formatVal(vehicle.maxWeight)} كغ',
                    color: color,
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: _buildInfoChip(
                    context,
                    icon: Icons.aspect_ratio_rounded,
                    title: 'الطول',
                    value: '${_formatVal(vehicle.minLength)} - ${_formatVal(vehicle.maxLength)} سم',
                    color: color,
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
                    icon: Icons.height_rounded,
                    title: 'الارتفاع',
                    value: '${_formatVal(vehicle.minHeight)} - ${_formatVal(vehicle.maxHeight)} سم',
                    color: color,
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: _buildInfoChip(
                    context,
                    icon: Icons.width_full_rounded,
                    title: 'العرض',
                    value: '${_formatVal(vehicle.minWidth)} - ${_formatVal(vehicle.maxWidth)} سم',
                    color: color,
                  ),
                ),
              ],
            ),
            verticalSpace(40),
          ],
        ),
      ),
    );
  }


  Widget _buildInfoChip(BuildContext context, {required IconData icon, required String title, required String value, required Color color}) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28.sp),
          verticalSpace(12),
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          verticalSpace(4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildTechSpec(BuildContext context, {required String title, required String value, required IconData icon}) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 22.sp),
          verticalSpace(8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          verticalSpace(4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}