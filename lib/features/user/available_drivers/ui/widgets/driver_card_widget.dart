import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';
import '../../data/models/driver_model.dart';
import 'badge/driver_badge_widget.dart';
import 'card_components/driver_card_header.dart';
import 'card_components/driver_info_box.dart';
import 'card_components/driver_card_footer.dart';

class DriverCardWidget extends StatelessWidget {
  final DriverModel driver;
  const DriverCardWidget({
    super.key,
    required this.driver,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 32.h, top: 10.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomShadowCard(
          
            child: Column(
              children: [
                DriverCardHeader(
                  driverId: driver.id,
                  firstName: driver.firstName,
                  lastName: driver.lastName,
                  rating: driver.rating,
                ),
                verticalSpace(16),

                Row(
                  children: [
                    Expanded(
                      child: InfoBox(
                        title: 'المسافة إليك',
                        value: '${driver.distanceToStartKm} كم',
                        icon: Icons.location_on_outlined,
                      ),
                    ),
                    horizontalSpace(8),
                    Expanded(
                      child: InfoBox(
                        title: 'مسافة الشحنة',
                        value: '${driver.distanceOfShipment} كم',
                        icon: Icons.map_outlined,
                      ),
                    ),
                  ],
                ),
                verticalSpace(8),

                InfoBox(
                  title: 'وسيلة النقل',
                  value: driver.vehicle,
                  icon: Icons.local_shipping_outlined,
                ),
                verticalSpace(24),

              DriverCardFooter(driver: driver),
              ],
            ),
          ),

          Positioned(
            top: -10.h,
            left: 32.w,
            child: DriverBadgeWidget(
              badgeTitle: driver.badge,
              badgeDescription: driver.badgeText,
            ),
          ),

          
        ],
      ),
    );
  }
}
