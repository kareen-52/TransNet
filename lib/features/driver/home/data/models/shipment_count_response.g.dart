// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentCountResponse _$ShipmentCountResponseFromJson(
  Map<String, dynamic> json,
) => ShipmentCountResponse(
  count: (json['count'] as num).toInt(),
  availability: (json['availability'] as num).toInt(),
  reward: json['reward'] as String,
);

Map<String, dynamic> _$ShipmentCountResponseToJson(
  ShipmentCountResponse instance,
) => <String, dynamic>{
  'count': instance.count,
  'availability': instance.availability,
  'reward': instance.reward,
};
