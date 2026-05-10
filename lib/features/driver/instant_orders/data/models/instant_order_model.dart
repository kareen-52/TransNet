import 'dart:convert';

class InstantOrderModel {
  final int userId;
  final int driverId;
  final double price;
  final double distanceToStart;
  final double shipmentDistance;
  
  final double weight;
  final double height;
  final double width;
  final double length;
  final String object;
  final bool insurance;
  
  final String fromLocation;
  final String toLocation;
  final String expiresAt;

  InstantOrderModel({
    required this.userId, required this.driverId, required this.price,
    required this.distanceToStart, required this.shipmentDistance,
    required this.weight, required this.height, required this.width,
    required this.length, required this.object, required this.insurance,
    required this.fromLocation, required this.toLocation, required this.expiresAt,
  });


  factory InstantOrderModel.fromFcmPayload(Map<String, dynamic> fcmData) {
    final String rawPayload = fcmData['notification'] ?? '{}';
    final Map<String, dynamic> parsedData = jsonDecode(rawPayload);
    final Map<String, dynamic> shipment = parsedData['shipment'] ?? {};

    return _buildFromMap(parsedData, shipment);
  }

  factory InstantOrderModel.fromJson(Map<String, dynamic> apiData) {
    final Map<String, dynamic> shipment = apiData['shipment'] ?? {};
    return _buildFromMap(apiData, shipment);
  }

  static InstantOrderModel _buildFromMap(Map<String, dynamic> data, Map<String, dynamic> shipment) {
    return InstantOrderModel(
      userId: data['user_id'] ?? 0,
      driverId: data['driver_id'] ?? 0,
      price: double.tryParse(data['price'].toString()) ?? 0.0,
      distanceToStart: double.tryParse(data['distance_to_start'].toString()) ?? 0.0,
      shipmentDistance: double.tryParse(data['shipment_distance'].toString()) ?? 0.0,
      weight: double.tryParse(shipment['weight'].toString()) ?? 0.0,
      height: double.tryParse(shipment['height'].toString()) ?? 0.0,
      width: double.tryParse(shipment['width'].toString()) ?? 0.0,
      length: double.tryParse(shipment['length'].toString()) ?? 0.0,
      object: shipment['object'] ?? 'غير محدد',
      insurance: shipment['insurance'] == true || shipment['insurance'] == 'true' || shipment['insurance'] == 1,
      fromLocation: shipment['start_governorate'] ?? 'غير محدد',
      toLocation: shipment['end_governorate'] ?? 'غير محدد',
      expiresAt: data['expires_at'] ?? '',
    );
  }
}