import 'package:json_annotation/json_annotation.dart';
part 'shipment_model.g.dart';

bool _parseBool(dynamic value) {
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) return value == '1' || value.toLowerCase() == 'true';
  return false;
}

@JsonSerializable()
class ShipmentModel {
  final double weight, height, width, length;
  final String object;
  @JsonKey(fromJson: _parseBool)
  // final bool insurance;
  @JsonKey(name: 'start_position_lat')
  final dynamic startPositionLat;
  @JsonKey(name: 'start_position_lng')
  final dynamic startPositionLng;
  @JsonKey(name: 'end_position_lat')
  final dynamic endPositionLat;
  @JsonKey(name: 'end_position_lng')
  final dynamic endPositionLng;
  @JsonKey(name: 'start_governorate_id')
  final dynamic startGovernorateId;
  @JsonKey(name: 'end_governorate_id')
  final dynamic endGovernorateId;
  @JsonKey(name: 'expires_at')
  final String expiresAt;


  final PendingDriverModel? driver;

  ShipmentModel({
    required this.weight,
    required this.height,
    required this.width,
    required this.length,
    required this.object,
    // required this.insurance,
    required this.startPositionLat,
    required this.startPositionLng,
    required this.endPositionLat,
    required this.endPositionLng,
    required this.startGovernorateId,
    required this.endGovernorateId,
    required this.expiresAt,
    this.driver,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) =>
      _$ShipmentModelFromJson(json);
}


@JsonSerializable()
class PendingDriverModel {
  @JsonKey(name: 'driver_id')
  final int driverId;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'expires_at')
  final String expiresAt;

  PendingDriverModel({
    required this.driverId,
    required this.firstName,
    required this.lastName,
    required this.expiresAt,
  });

  factory PendingDriverModel.fromJson(Map<String, dynamic> json) =>
      _$PendingDriverModelFromJson(json);
}