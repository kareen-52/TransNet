import 'package:flutter/material.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/features/user/home_screen/logic/home_cubit.dart';

class ShipmentNavigationHelper {
  static void openStepperAndHandleResult(BuildContext context, HomeCubit cubit) {
    Navigator.pushNamed(context, Routes.createShipment).then((result) {
      if (context.mounted) {
        if (result == 'goToDrivers') {
          Navigator.pushNamed(context, Routes.availableDriversScreen).then((_) {
            if (context.mounted) cubit.checkActiveShipment();
          });
        } else {
          cubit.checkActiveShipment();
        }
      }
    });
  }
}