import 'package:json_annotation/json_annotation.dart';

part 'shipment_details_response.g.dart';

@JsonSerializable()
class ShipmentDetailsResponse {
  final ShipmentDetail shipment;
  final RouteGeometry? route_geometry;
  final dynamic live_tracking;
  final PartyInfo? driver;  
  final PartyInfo? client;  

  ShipmentDetailsResponse({
    required this.shipment,
    this.route_geometry,
    this.live_tracking,
    this.driver,
    this.client,
  });

  factory ShipmentDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ShipmentDetailsResponseFromJson(json);
}

@JsonSerializable()
class ShipmentDetail {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'driver_id')
  final int? driverId;
  @JsonKey(name: 'shipment_number')
  final int shipmentNumber;
  final String? weight;
  final String? height;
  final String? width;
  final String? length;
  final String? object;
  final int? insurance;
  @JsonKey(name: 'start_position_lat')
  final String startPositionLat;
  @JsonKey(name: 'start_position_lng')
  final String startPositionLng;
  @JsonKey(name: 'end_position_lat')
  final String endPositionLat;
  @JsonKey(name: 'end_position_lng')
  final String endPositionLng;
  final int? price;
  final String? status;
  final int? success;
  @JsonKey(name: 'delivery_deadline')
  final String? deliveryDeadline;
  final int? paid;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'start_governorate')
  final String startGovernorate;
  @JsonKey(name: 'end_governorate')
  final String endGovernorate;

  ShipmentDetail({
    required this.id,
    required this.userId,
    this.driverId,
    required this.shipmentNumber,
    this.weight,
    this.height,
    this.width,
    this.length,
    this.object,
    this.insurance,
    required this.startPositionLat,
    required this.startPositionLng,
    required this.endPositionLat,
    required this.endPositionLng,
    this.price,
    this.status,
    this.success,
    this.deliveryDeadline,
    this.paid,
    required this.createdAt,
    required this.updatedAt,
    required this.startGovernorate,
    required this.endGovernorate,
  });

  factory ShipmentDetail.fromJson(Map<String, dynamic> json) =>
      _$ShipmentDetailFromJson(json);
}

@JsonSerializable()
class RouteGeometry {
  final List<List<double>> coordinates;
  final String type;

  RouteGeometry({required this.coordinates, required this.type});

  factory RouteGeometry.fromJson(Map<String, dynamic> json) =>
      _$RouteGeometryFromJson(json);
}

@JsonSerializable()
class PartyInfo {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'user_number')
  final String userNumber;

  PartyInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userNumber,
  });

  factory PartyInfo.fromJson(Map<String, dynamic> json) =>
      _$PartyInfoFromJson(json);
}