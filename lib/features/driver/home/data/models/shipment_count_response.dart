
import 'package:json_annotation/json_annotation.dart';

part 'shipment_count_response.g.dart';

@JsonSerializable()
class ShipmentCountResponse {
  final int count;
  final int availability;

  ShipmentCountResponse({required this.count, required this.availability});

  factory ShipmentCountResponse.fromJson(Map<String, dynamic> json) =>
      _$ShipmentCountResponseFromJson(json);


}