import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/pin_qr/pin_card.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/pin_qr/qr_button.dart';

class PinQrRow extends StatelessWidget {
  final ShipmentEntity shipment;
  final bool isDark;

  const PinQrRow({
    super.key,
    required this.shipment,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (shipment.hasPin)
            Expanded(child: PinCard(pin: shipment.pin!, isDark: isDark)),
          if (shipment.hasPin && shipment.hasQrPin)
            SizedBox(width: 10.w),
          if (shipment.hasQrPin)
            QrButton(qrPin: shipment.qrPin!, isDark: isDark),
        ],
      ),
    );
  }
}
