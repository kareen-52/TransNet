import 'package:json_annotation/json_annotation.dart';
part 'driver_set_location_request.g.dart';

@JsonSerializable()
class DriverSetLocationRequest {
  final double lat;
  final double lng;

  DriverSetLocationRequest({required this.lat, required this.lng});

  Map<String, dynamic> toJson() => _$DriverSetLocationRequestToJson(this);
}