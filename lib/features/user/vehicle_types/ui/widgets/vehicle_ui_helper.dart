import 'package:flutter/material.dart';

class VehicleUiHelper {
  static IconData getIconForVehicle(String type) {
    if (type.contains('دراجة')) return Icons.two_wheeler_rounded;
    if (type.contains('سيارة')) return Icons.directions_car_filled_rounded;
    if (type.contains('صغيرة')) return Icons.local_shipping_outlined;
    if (type.contains('متوسطة')) return Icons.local_shipping_rounded;
    if (type.contains('كبيرة')) return Icons.fire_truck_rounded;
    return Icons.local_shipping_rounded;
  }

  static Color getColorForVehicle(String type) {
    if (type.contains('دراجة')) return Colors.lightBlue;
    if (type.contains('سيارة')) return Colors.teal;
    if (type.contains('صغيرة')) return Colors.pink;
    if (type.contains('متوسطة')) return Colors.deepPurple;
    if (type.contains('كبيرة')) return Colors.lightGreen;
    return Colors.blueGrey;
  }
}
