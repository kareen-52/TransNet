import 'package:json_annotation/json_annotation.dart';
part 'shipment_model.g.dart';

@JsonSerializable()
class ShipmentModel {
  final double weight, height, width, length;
  final String object;
  final bool insurance;
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

  ShipmentModel({
    required this.weight,
    required this.height,
    required this.width,
    required this.length,
    required this.object,
    required this.insurance,
    required this.startPositionLat,
    required this.startPositionLng,
    required this.endPositionLat,
    required this.endPositionLng,
    required this.startGovernorateId,
    required this.endGovernorateId,
    required this.expiresAt,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) =>
      _$ShipmentModelFromJson(json);
}
