import 'package:json_annotation/json_annotation.dart';
part 'driver_model.g.dart';

@JsonSerializable()
class DriverModel {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final double rating;
  final String vehicle;
  @JsonKey(name: 'distance_to_start_km')
  final double distanceToStartKm;
  @JsonKey(name: 'distance_of_shipment')
  final double distanceOfShipment;
  final double price;
  final String badge;
  @JsonKey(name: 'badge_text')
  final String badgeText;

  DriverModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.rating,
    required this.vehicle,
    required this.distanceToStartKm,
    required this.distanceOfShipment,
    required this.price,
    required this.badge,
    required this.badgeText,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) => _$DriverModelFromJson(json);
}

@JsonSerializable()
class AvailableDriversResponse {
  final List<DriverModel> data;
  AvailableDriversResponse({required this.data});
  factory AvailableDriversResponse.fromJson(Map<String, dynamic> json) => _$AvailableDriversResponseFromJson(json);
}