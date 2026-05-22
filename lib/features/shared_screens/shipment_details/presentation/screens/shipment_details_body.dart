import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/cards/shipment_cargo_card.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/cards/shipment_header_card.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/cards/shipment_party_card.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/cards/shipment_route_card.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/cards/shipment_status_card.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/section_header.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/shipment_app_bar.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/map/shipment_map_card.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/pin_qr/pin_qr_row.dart';

/// Renders the success state of the Shipment Details screen.
///
/// Responsibility: layout only — composing section widgets in the correct
/// visual order. No business logic, no state management.
class ShipmentDetailsBody extends StatelessWidget {
  final ShipmentDetailsEntity data;

  const ShipmentDetailsBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final shipment = data.shipment;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        ShipmentAppBar(data: data, isDark: isDark),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 40.h),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 12.h),

              // ① Shipment number + status + copy
              ShipmentHeaderCard(shipment: shipment, isDark: isDark),
              SizedBox(height: 14.h),

              // ② PIN + QR (conditional)
              if (shipment.hasPin || shipment.hasQrPin) ...[
                PinQrRow(shipment: shipment, isDark: isDark),
                SizedBox(height: 14.h),
              ],

              // ③ Route summary
              SectionHeader(
                label: 'مسار الشحنة',
                icon: Icons.route_rounded,
                color: AppColors.primary,
              ),
              SizedBox(height: 8.h),
              ShipmentRouteCard(shipment: shipment, isDark: isDark),
              SizedBox(height: 14.h),

              // ④ Map preview card
              SectionHeader(
                label: 'خريطة الرحلة',
                icon: Icons.map_rounded,
                color: AppColors.primary,
              ),
              SizedBox(height: 8.h),
              ShipmentMapCard(
                routeGeometry: data.routeGeometry,
                shipment: shipment,
                isDark: isDark,
              ),
              SizedBox(height: 14.h),

              // ⑤ Cargo details (price + dimensions + weight)
              SectionHeader(
                label: 'تفاصيل الشحنة',
                icon: Icons.inventory_2_outlined,
                color: AppColors.primary,
              ),
              SizedBox(height: 8.h),
              ShipmentCargoCard(shipment: shipment, isDark: isDark),
              SizedBox(height: 14.h),

              // ⑥ Status (payment + delivery date)
              SectionHeader(
                label: 'حالة الشحنة',
                icon: Icons.info_outline_rounded,
                color: AppColors.primary,
              ),
              SizedBox(height: 8.h),
              ShipmentStatusCard(shipment: shipment, isDark: isDark),
              SizedBox(height: 14.h),

              // ⑦ Parties (driver + client)
              if (data.hasParties) ...[
                SectionHeader(
                  label: 'الأطراف',
                  icon: Icons.people_outline_rounded,
                  color: AppColors.primary,
                ),
                SizedBox(height: 8.h),
                if (data.hasDriver) ...[
                  ShipmentPartyCard(
                    party: data.driver!,
                    role: 'السائق',
                    isDark: isDark,
                    icon: Icons.drive_eta_outlined,
                    iconColor: AppColors.primary,
                  ),
                  SizedBox(height: 10.h),
                ],
                if (data.hasClient)
                  ShipmentPartyCard(
                    party: data.client!,
                    role: 'العميل',
                    isDark: isDark,
                    icon: Icons.person_outline_rounded,
                    iconColor: AppColors.secondary,
                  ),
                SizedBox(height: 4.h),
              ],
            ]),
          ),
        ),
      ],
    );
  }
}
