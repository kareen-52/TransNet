import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/cards/cargo_price_header.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/cards/cargo_details_body.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/card_decoration.dart';

/// Orchestrates the cargo card — composes price header and details body.
/// All child rendering is delegated to [CargoPriceHeader] and [CargoDetailsBody].
class ShipmentCargoCard extends StatelessWidget {
  final ShipmentEntity shipment;
  final bool isDark;

  const ShipmentCargoCard({
    super.key,
    required this.shipment,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      decoration: buildCardDecoration(surface: surface, border: border, isDark: isDark),
      child: Column(
        children: [
          CargoPriceHeader(shipment: shipment),
          CargoDetailsBody(shipment: shipment, isDark: isDark),
        ],
      ),
    );
  }
}
