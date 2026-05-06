import 'package:json_annotation/json_annotation.dart';
part 'send_to_driver_request.g.dart';

@JsonSerializable()
class SendToDriverRequest {
  @JsonKey(name: 'driver_id')
  final int driverId;
  final double price;
  @JsonKey(name: 'distanceToStart')
  final double distanceToStart;
  @JsonKey(name: 'shipmentDistance')
  final double shipmentDistance;

  SendToDriverRequest({
    required this.driverId,
    required this.price,
    required this.distanceToStart,
    required this.shipmentDistance,
  });

  Map<String, dynamic> toJson() => _$SendToDriverRequestToJson(this);
}