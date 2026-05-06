// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentModel _$ShipmentModelFromJson(Map<String, dynamic> json) =>
    ShipmentModel(
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      length: (json['length'] as num).toDouble(),
      object: json['object'] as String,
      insurance: json['insurance'] as bool,
      startPositionLat: json['start_position_lat'],
      startPositionLng: json['start_position_lng'],
      endPositionLat: json['end_position_lat'],
      endPositionLng: json['end_position_lng'],
      startGovernorateId: json['start_governorate_id'],
      endGovernorateId: json['end_governorate_id'],
      expiresAt: json['expires_at'] as String,
    );

Map<String, dynamic> _$ShipmentModelToJson(ShipmentModel instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'height': instance.height,
      'width': instance.width,
      'length': instance.length,
      'object': instance.object,
      'insurance': instance.insurance,
      'start_position_lat': instance.startPositionLat,
      'start_position_lng': instance.startPositionLng,
      'end_position_lat': instance.endPositionLat,
      'end_position_lng': instance.endPositionLng,
      'start_governorate_id': instance.startGovernorateId,
      'end_governorate_id': instance.endGovernorateId,
      'expires_at': instance.expiresAt,
    };
