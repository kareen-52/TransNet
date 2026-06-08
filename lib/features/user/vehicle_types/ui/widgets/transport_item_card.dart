import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';
import 'package:graduation_progect/features/user/vehicle_types/ui/widgets/vehicle_ui_helper.dart';
import '../../data/models/vehicle_type_model.dart';
import 'vehicle_details_screen.dart';

class TransportItemCard extends StatelessWidget {
  final VehicleTypeModel vehicle;

  const TransportItemCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icon = VehicleUiHelper.getIconForVehicle(vehicle.type);
    final color = VehicleUiHelper.getColorForVehicle(vehicle.type);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.vehicleDetailsScreen,
          arguments: vehicle,
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: CustomShadowCard(
        padding: EdgeInsets.all(12.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 28.sp),
            ),
            verticalSpace(8),
            Text(
              vehicle.type,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeightHelper.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            verticalSpace(4),
            Text(
              'يبدأ من ${double.parse(vehicle.baseFare).round()} ل.س', 
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}