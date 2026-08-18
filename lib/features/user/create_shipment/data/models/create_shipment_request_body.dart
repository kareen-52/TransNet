import 'package:json_annotation/json_annotation.dart';
part 'create_shipment_request_body.g.dart';

@JsonSerializable()
class CreateShipmentRequestBody {
  final double weight;
  final double height;
  final double width;
  final double length;
  final String object;
  @JsonKey(name: 'start_position_lat')
  final double startPositionLat;
  @JsonKey(name: 'start_position_lng')
  final double startPositionLng;
  @JsonKey(name: 'end_position_lat')
  final double endPositionLat;
  @JsonKey(name: 'end_position_lng')
  final double endPositionLng;
  @JsonKey(name: 'start_governorate_id')
  final int startGovernorateId;
  @JsonKey(name: 'end_governorate_id')
  final int endGovernorateId;

  CreateShipmentRequestBody({
    required this.weight,
    required this.height,
    required this.width,
    required this.length,
    required this.object,
    required this.startPositionLat,
    required this.startPositionLng,
    required this.endPositionLat,
    required this.endPositionLng,
    required this.startGovernorateId,
    required this.endGovernorateId,
  });

  Map<String, dynamic> toJson() => _$CreateShipmentRequestBodyToJson(this);
}
