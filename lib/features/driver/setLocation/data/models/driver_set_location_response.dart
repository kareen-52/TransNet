import 'package:json_annotation/json_annotation.dart';
part 'driver_set_location_response.g.dart';

@JsonSerializable()
class DriverSetLocationResponse {
  final String? message;

  DriverSetLocationResponse({this.message});

  factory DriverSetLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverSetLocationResponseFromJson(json);
}