// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      car: json['car'] == null
          ? null
          : CarData.fromJson(json['car'] as Map<String, dynamic>),
      driverGovernorates: (json['driver_governorates'] as List<dynamic>?)
          ?.map((e) => GovernorateData.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageRate: (json['average_rate'] as num?)?.toDouble(),
      badge: json['badge'] == null
          ? null
          : BadgeData.fromJson(json['badge'] as Map<String, dynamic>),
      statistics: json['statisics'] == null
          ? null
          : DriverStatisticsModel.fromJson(
              json['statisics'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'car': instance.car,
      'driver_governorates': instance.driverGovernorates,
      'average_rate': instance.averageRate,
      'badge': instance.badge,
      'statisics': instance.statistics,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  id: (json['id'] as num?)?.toInt(),
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  userNumber: json['user_number'] as String?,
  phoneNumber: json['phone_number'] as String?,
  driverId: (json['driver_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'id': instance.id,
  'driver_id': instance.driverId,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'user_number': instance.userNumber,
  'phone_number': instance.phoneNumber,
};

CarData _$CarDataFromJson(Map<String, dynamic> json) => CarData(
  id: (json['id'] as num?)?.toInt(),
  vehicleTypeId: (json['vehicle_type_id'] as num?)?.toInt(),
  manufacturer: json['manufacturer'] as String?,
  model: json['model'] as String?,
  yearOfManufacture: (json['year_of_manufacture'] as num?)?.toInt(),
  color: json['color'] as String?,
  licensePlateNumber: json['license_plate_number'] as String?,
  vehicleType: json['vehicle_type'] == null
      ? null
      : VehicleTypeData.fromJson(json['vehicle_type'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CarDataToJson(CarData instance) => <String, dynamic>{
  'id': instance.id,
  'vehicle_type_id': instance.vehicleTypeId,
  'manufacturer': instance.manufacturer,
  'model': instance.model,
  'year_of_manufacture': instance.yearOfManufacture,
  'color': instance.color,
  'license_plate_number': instance.licensePlateNumber,
  'vehicle_type': instance.vehicleType,
};

VehicleTypeData _$VehicleTypeDataFromJson(Map<String, dynamic> json) =>
    VehicleTypeData(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$VehicleTypeDataToJson(VehicleTypeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'description': instance.description,
    };

GovernorateData _$GovernorateDataFromJson(Map<String, dynamic> json) =>
    GovernorateData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GovernorateDataToJson(GovernorateData instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

BadgeData _$BadgeDataFromJson(Map<String, dynamic> json) => BadgeData(
  level: (json['level'] as num?)?.toInt(),
  name: json['name'] as String?,
  text: json['text'] as String?,
);

Map<String, dynamic> _$BadgeDataToJson(BadgeData instance) => <String, dynamic>{
  'level': instance.level,
  'name': instance.name,
  'text': instance.text,
};
