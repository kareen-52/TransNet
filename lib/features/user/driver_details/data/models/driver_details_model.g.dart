// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverDetailsModel _$DriverDetailsModelFromJson(Map<String, dynamic> json) =>
    DriverDetailsModel(
      user: DriverUserModel.fromJson(json['user'] as Map<String, dynamic>),
      car: DriverCarModel.fromJson(json['car'] as Map<String, dynamic>),
      driverGovernorates: (json['driver_governorates'] as List<dynamic>)
          .map((e) => GovernorateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageRate: (json['average_rate'] as num).toDouble(),
      badge: DriverBadgeModel.fromJson(json['badge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DriverDetailsModelToJson(DriverDetailsModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'car': instance.car,
      'driver_governorates': instance.driverGovernorates,
      'average_rate': instance.averageRate,
      'badge': instance.badge,
    };

DriverUserModel _$DriverUserModelFromJson(Map<String, dynamic> json) =>
    DriverUserModel(
      userId: (json['user_id'] as num).toInt(),
      driverId: json['driver_id'],
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      userNumber: json['user_number'] as String,
      phoneNumber: json['phone_number'] as String,
    );

Map<String, dynamic> _$DriverUserModelToJson(DriverUserModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'driver_id': instance.driverId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_number': instance.userNumber,
      'phone_number': instance.phoneNumber,
    };

DriverCarModel _$DriverCarModelFromJson(Map<String, dynamic> json) =>
    DriverCarModel(
      id: (json['id'] as num).toInt(),
      vehicleTypeId: (json['vehicle_type_id'] as num).toInt(),
      manufacturer: json['manufacturer'] as String,
      model: json['model'] as String,
      yearOfManufacture: (json['year_of_manufacture'] as num).toInt(),
      color: json['color'] as String,
      licensePlateNumber: json['license_plate_number'] as String,
      vehicleType: CarVehicleTypeModel.fromJson(
        json['vehicle_type'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$DriverCarModelToJson(DriverCarModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicle_type_id': instance.vehicleTypeId,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'year_of_manufacture': instance.yearOfManufacture,
      'color': instance.color,
      'license_plate_number': instance.licensePlateNumber,
      'vehicle_type': instance.vehicleType,
    };

CarVehicleTypeModel _$CarVehicleTypeModelFromJson(Map<String, dynamic> json) =>
    CarVehicleTypeModel(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CarVehicleTypeModelToJson(
  CarVehicleTypeModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'description': instance.description,
};

DriverBadgeModel _$DriverBadgeModelFromJson(Map<String, dynamic> json) =>
    DriverBadgeModel(
      level: (json['level'] as num).toInt(),
      name: json['name'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$DriverBadgeModelToJson(DriverBadgeModel instance) =>
    <String, dynamic>{
      'level': instance.level,
      'name': instance.name,
      'text': instance.text,
    };
