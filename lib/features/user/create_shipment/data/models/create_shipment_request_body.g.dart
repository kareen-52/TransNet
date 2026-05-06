// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_shipment_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateShipmentRequestBody _$CreateShipmentRequestBodyFromJson(
  Map<String, dynamic> json,
) => CreateShipmentRequestBody(
  weight: (json['weight'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  length: (json['length'] as num).toDouble(),
  object: json['object'] as String,
  insurance: json['insurance'] as bool,
  startPositionLat: (json['start_position_lat'] as num).toDouble(),
  startPositionLng: (json['start_position_lng'] as num).toDouble(),
  endPositionLat: (json['end_position_lat'] as num).toDouble(),
  endPositionLng: (json['end_position_lng'] as num).toDouble(),
  startGovernorateId: (json['start_governorate_id'] as num).toInt(),
  endGovernorateId: (json['end_governorate_id'] as num).toInt(),
);

Map<String, dynamic> _$CreateShipmentRequestBodyToJson(
  CreateShipmentRequestBody instance,
) => <String, dynamic>{
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
};
