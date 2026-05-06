// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) => DriverModel(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  rating: (json['rating'] as num).toDouble(),
  vehicle: json['vehicle'] as String,
  distanceToStartKm: (json['distance_to_start_km'] as num).toDouble(),
  distanceOfShipment: (json['distance_of_shipment'] as num).toDouble(),
  price: (json['price'] as num).toDouble(),
  badge: json['badge'] as String,
  badgeText: json['badge_text'] as String,
);

Map<String, dynamic> _$DriverModelToJson(DriverModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'rating': instance.rating,
      'vehicle': instance.vehicle,
      'distance_to_start_km': instance.distanceToStartKm,
      'distance_of_shipment': instance.distanceOfShipment,
      'price': instance.price,
      'badge': instance.badge,
      'badge_text': instance.badgeText,
    };

AvailableDriversResponse _$AvailableDriversResponseFromJson(
  Map<String, dynamic> json,
) => AvailableDriversResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => DriverModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AvailableDriversResponseToJson(
  AvailableDriversResponse instance,
) => <String, dynamic>{'data': instance.data};
