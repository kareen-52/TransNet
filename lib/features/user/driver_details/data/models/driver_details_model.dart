import 'package:json_annotation/json_annotation.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/governorate_model.dart';
part 'driver_details_model.g.dart';

@JsonSerializable()
class DriverDetailsModel {
  final DriverUserModel user;
  final DriverCarModel car;
  @JsonKey(name: 'driver_governorates')
  final List<GovernorateModel> driverGovernorates;
  @JsonKey(name: 'average_rate')
  final double averageRate;
  final DriverBadgeModel badge;

  DriverDetailsModel({
    required this.user,
    required this.car,
    required this.driverGovernorates,
    required this.averageRate,
    required this.badge,
  });

  factory DriverDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DriverDetailsModelFromJson(json);
}

@JsonSerializable()
class DriverUserModel {
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'driver_id')
  final dynamic driverId;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'user_number')
  final String userNumber;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  DriverUserModel({
    required this.userId,
    required this.driverId,
    required this.firstName,
    required this.lastName,
    required this.userNumber,
    required this.phoneNumber,
  });
  factory DriverUserModel.fromJson(Map<String, dynamic> json) =>
      _$DriverUserModelFromJson(json);
}

@JsonSerializable()
class DriverCarModel {
  final int id;
  @JsonKey(name: 'vehicle_type_id')
  final int vehicleTypeId;
  final String manufacturer;
  final String model;
  @JsonKey(name: 'year_of_manufacture')
  final int yearOfManufacture;
  final String color;
  @JsonKey(name: 'license_plate_number')
  final String licensePlateNumber;
  @JsonKey(name: 'vehicle_type')
  final CarVehicleTypeModel vehicleType;

  DriverCarModel({
    required this.id,
    required this.vehicleTypeId,
    required this.manufacturer,
    required this.model,
    required this.yearOfManufacture,
    required this.color,
    required this.licensePlateNumber,
    required this.vehicleType,
  });
  factory DriverCarModel.fromJson(Map<String, dynamic> json) =>
      _$DriverCarModelFromJson(json);
}

@JsonSerializable()
class CarVehicleTypeModel {
  final int id;
  final String type;
  final String description;

  CarVehicleTypeModel({
    required this.id,
    required this.type,
    required this.description,
  });
  factory CarVehicleTypeModel.fromJson(Map<String, dynamic> json) =>
      _$CarVehicleTypeModelFromJson(json);
}

@JsonSerializable()
class DriverBadgeModel {
  final int level;
  final String name;
  final String text;

  DriverBadgeModel({
    required this.level,
    required this.name,
    required this.text,
  });
  factory DriverBadgeModel.fromJson(Map<String, dynamic> json) =>
      _$DriverBadgeModelFromJson(json);
}
