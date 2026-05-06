// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_set_location_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverSetLocationRequest _$DriverSetLocationRequestFromJson(
  Map<String, dynamic> json,
) => DriverSetLocationRequest(
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$DriverSetLocationRequestToJson(
  DriverSetLocationRequest instance,
) => <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};
