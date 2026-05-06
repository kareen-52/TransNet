import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';

class CarDetailsScreen extends StatelessWidget {
  final CarData carData;

  const CarDetailsScreen({super.key, required this.carData});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل وسيلة النقل'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.directions_car,
                size: 80.sp,
                color: colorScheme.primary,
              ),
            ),
            verticalSpace(24),
            _buildInfoCard(context, carData),
            verticalSpace(24),
            if (carData.vehicleType != null)
              _buildVehicleTypeCard(context, carData.vehicleType!),
            verticalSpace(40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, CarData car) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            context,
            'الشركة المصنعة',
            car.manufacturer ?? 'غير محدد',
          ),
          _buildDivider(context),
          _buildDetailRow(context, 'الموديل', car.model ?? 'غير محدد'),
          _buildDivider(context),
          _buildDetailRow(
            context,
            'سنة الصنع',
            car.yearOfManufacture?.toString() ?? 'غير محدد',
          ),
          _buildDivider(context),
          _buildDetailRow(context, 'اللون', car.color ?? 'غير محدد'),
          _buildDivider(context),
          _buildDetailRow(
            context,
            'رقم اللوحة',
            car.licensePlateNumber ?? 'غير محدد',
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleTypeCard(
    BuildContext context,
    VehicleTypeData vehicleType,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Icon(Icons.category, color: colorScheme.primary),
                horizontalSpace(12),
                Text(
                  'نوع المركبة',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildDivider(context),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicleType.type ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                verticalSpace(8),
                Text(
                  vehicleType.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      indent: 16.w,
      endIndent: 16.w,
      color: Theme.of(context).colorScheme.outline,
    );
  }
}
