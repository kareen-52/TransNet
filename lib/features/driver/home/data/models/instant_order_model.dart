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

    return InstantOrderModel(
      userId: parsedData['user_id'] ?? 0,
      driverId: parsedData['driver_id'] ?? 0,
      price: double.tryParse(parsedData['price'].toString()) ?? 0.0,
      distanceToStart: double.tryParse(parsedData['distance_to_start'].toString()) ?? 0.0,
      shipmentDistance: double.tryParse(parsedData['shipment_distance'].toString()) ?? 0.0,
      weight: double.tryParse(shipment['weight'].toString()) ?? 0.0,
      height: double.tryParse(shipment['height'].toString()) ?? 0.0,
      width: double.tryParse(shipment['width'].toString()) ?? 0.0,
      length: double.tryParse(shipment['length'].toString()) ?? 0.0,
      object: shipment['object'] ?? 'غير محدد',
      insurance: shipment['insurance'] == true || shipment['insurance'] == 'true' || shipment['insurance'] == 1,
      fromLocation: shipment['start_governorate'] ?? 'غير محدد',
      toLocation: shipment['end_governorate'] ?? 'غير محدد',
      expiresAt: parsedData['expires_at'] ?? '',
    );
  }

  // 🔥 1. لتحويل المودل إلى Map لتخزينه في الكاش المحلي
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'driver_id': driverId,
      'price': price,
      'distance_to_start': distanceToStart,
      'shipment_distance': shipmentDistance,
      'weight': weight,
      'height': height,
      'width': width,
      'length': length,
      'object': object,
      'insurance': insurance,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'expires_at': expiresAt,
    };
  }

  // 🔥 2. لقراءة المودل من الكاش المحلي
  factory InstantOrderModel.fromMap(Map<String, dynamic> map) {
    return InstantOrderModel(
      userId: map['user_id'] ?? 0,
      driverId: map['driver_id'] ?? 0,
      price: double.tryParse(map['price'].toString()) ?? 0.0,
      distanceToStart: double.tryParse(map['distance_to_start'].toString()) ?? 0.0,
      shipmentDistance: double.tryParse(map['shipment_distance'].toString()) ?? 0.0,
      weight: double.tryParse(map['weight'].toString()) ?? 0.0,
      height: double.tryParse(map['height'].toString()) ?? 0.0,
      width: double.tryParse(map['width'].toString()) ?? 0.0,
      length: double.tryParse(map['length'].toString()) ?? 0.0,
      object: map['object'] ?? '',
      insurance: map['insurance'] ?? false,
      fromLocation: map['fromLocation'] ?? '',
      toLocation: map['toLocation'] ?? '',
      expiresAt: map['expires_at'] ?? '',
    );
  }
}