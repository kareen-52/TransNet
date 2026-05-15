import 'package:latlong2/latlong.dart';

class ActiveDriverShipmentModel {
  final int id;
  final int userId;
  final int driverId;
  final int shipmentNumber;
  final double price;
  final String status;
  final double startLat;
  final double startLng;
  final double endLat;
  final double endLng;
  final String startGovernorate;
  final String endGovernorate;
  final List<LatLng> pathCoordinates;
  final ActiveShipmentClientInfo? client;

  ActiveDriverShipmentModel({
    required this.id,
    required this.userId,
    required this.driverId,
    required this.shipmentNumber,
    required this.price,
    required this.status,
    required this.startLat,
    required this.startLng,
    required this.endLat,
    required this.endLng,
    required this.startGovernorate,
    required this.endGovernorate,
    required this.pathCoordinates,
    this.client,
  });

  factory ActiveDriverShipmentModel.fromJson(Map<String, dynamic> json) {
    List<LatLng> parsedPath = [];
    final path = json['path'];
    if (path != null && path['coordinates'] != null) {
      final coords = path['coordinates'] as List<dynamic>;
      for (final point in coords) {
        if (point is List && point.length >= 2) {
          parsedPath.add(LatLng(
            double.tryParse(point[1].toString()) ?? 0.0, // lat
            double.tryParse(point[0].toString()) ?? 0.0, // lng
          ));
        }
      }
    }

    return ActiveDriverShipmentModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      driverId: json['driver_id'] ?? 0,
      shipmentNumber: json['shipment_number'] ?? 0,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      status: json['status'] ?? '',
      startLat: double.tryParse(json['start_position_lat'].toString()) ?? 0.0,
      startLng: double.tryParse(json['start_position_lng'].toString()) ?? 0.0,
      endLat: double.tryParse(json['end_position_lat'].toString()) ?? 0.0,
      endLng: double.tryParse(json['end_position_lng'].toString()) ?? 0.0,
      startGovernorate: json['start_governorate'] ?? '',
      endGovernorate: json['end_governorate'] ?? '',
      pathCoordinates: parsedPath,
      client: json['client'] != null
          ? ActiveShipmentClientInfo.fromJson(json['client'])
          : null,
    );
  }
}



class ActiveShipmentClientInfo {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userNumber;

  ActiveShipmentClientInfo({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userNumber,
  });

  String get fullName => '$firstName $lastName';

  factory ActiveShipmentClientInfo.fromJson(Map<String, dynamic> json) {
    return ActiveShipmentClientInfo(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      userNumber: json['user_number'] ?? '',
    );
  }
}
