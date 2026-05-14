import 'package:latlong2/latlong.dart';

class RespondResponseModel {
  final String message;
  final ShipmentMapData? shipmentData;

  RespondResponseModel({required this.message, this.shipmentData});

  factory RespondResponseModel.fromJson(Map<String, dynamic> json) {
    return RespondResponseModel(
      message: json['message'] ?? 'تمت العملية',
      shipmentData: json['shipment_data'] != null
          ? ShipmentMapData.fromJson(json['shipment_data'])
          : null,
    );
  }
}

class ShipmentMapData {
  final int id;
  final double startLat;
  final double startLng;
  final double endLat;
  final double endLng;
  final List<LatLng> pathCoordinates;

  ShipmentMapData({
    required this.id,
    required this.startLat,
    required this.startLng,
    required this.endLat,
    required this.endLng,
    required this.pathCoordinates,
  });

  factory ShipmentMapData.fromJson(Map<String, dynamic> json) {
    // تحويل المصفوفة القادمة من الباك إند (GeoJSON [lng, lat]) إلى LatLng(lat, lng)
    List<LatLng> parsedPath = [];
    if (json['path'] != null && json['path']['coordinates'] != null) {
      final List<dynamic> coords = json['path']['coordinates'];
      for (var point in coords) {
        // GeoJSON يعيد [خط الطول, خط العرض]
        if (point is List && point.length >= 2) {
          parsedPath.add(LatLng(
            double.tryParse(point[1].toString()) ?? 0.0, // Latitude
            double.tryParse(point[0].toString()) ?? 0.0, // Longitude
          ));
        }
      }
    }

    return ShipmentMapData(
      id: json['id'] ?? 0,
      startLat: double.tryParse(json['start_position_lat'].toString()) ?? 0.0,
      startLng: double.tryParse(json['start_position_lng'].toString()) ?? 0.0,
      endLat: double.tryParse(json['end_position_lat'].toString()) ?? 0.0,
      endLng: double.tryParse(json['end_position_lng'].toString()) ?? 0.0,
      pathCoordinates: parsedPath,
    );
  }
}