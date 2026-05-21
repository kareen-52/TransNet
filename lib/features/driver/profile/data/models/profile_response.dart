import 'package:graduation_progect/features/driver/profile/data/models/driver_statistics_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  final UserData? user;
  final CarData? car;
  @JsonKey(name: 'driver_governorates')
  final List<GovernorateData>? driverGovernorates;
  @JsonKey(name: 'average_rate')
  final double? averageRate;
  final BadgeData? badge;
  @JsonKey(name: 'statisics')
  final DriverStatisticsModel? statistics;

  ProfileResponse({
    this.user,
    this.car,
    this.driverGovernorates,
    this.averageRate,
    this.badge,
    this.statistics,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  final int? id;
  @JsonKey(name: 'driver_id')
  final int? driverId;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'user_number')
  final String? userNumber;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.userNumber,
    this.phoneNumber,
     this.driverId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

@JsonSerializable()
class CarData {
  final int? id;
  @JsonKey(name: 'vehicle_type_id')
  final int? vehicleTypeId;
  final String? manufacturer;
  final String? model;
  @JsonKey(name: 'year_of_manufacture')
  final int? yearOfManufacture;
  final String? color;
  @JsonKey(name: 'license_plate_number')
  final String? licensePlateNumber;
  @JsonKey(name: 'vehicle_type')
  final VehicleTypeData? vehicleType;

  CarData({
    this.id,
    this.vehicleTypeId,
    this.manufacturer,
    this.model,
    this.yearOfManufacture,
    this.color,
    this.licensePlateNumber,
    this.vehicleType,
  });

  factory CarData.fromJson(Map<String, dynamic> json) =>
      _$CarDataFromJson(json);
}

@JsonSerializable()
class VehicleTypeData {
  final int? id;
  final String? type;
  final String? description;

  VehicleTypeData({this.id, this.type, this.description});

  factory VehicleTypeData.fromJson(Map<String, dynamic> json) =>
      _$VehicleTypeDataFromJson(json);
}

@JsonSerializable()
class GovernorateData {
  final int? id;
  final String? name;

  GovernorateData({this.id, this.name});

  factory GovernorateData.fromJson(Map<String, dynamic> json) =>
      _$GovernorateDataFromJson(json);
}

@JsonSerializable()
class BadgeData {
  final int? level;
  final String? name;
  final String? text;

  BadgeData({this.level, this.name, this.text});

  factory BadgeData.fromJson(Map<String, dynamic> json) =>
      _$BadgeDataFromJson(json);
}
