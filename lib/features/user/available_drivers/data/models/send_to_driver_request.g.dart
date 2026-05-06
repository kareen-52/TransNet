// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_to_driver_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendToDriverRequest _$SendToDriverRequestFromJson(Map<String, dynamic> json) =>
    SendToDriverRequest(
      driverId: (json['driver_id'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      distanceToStart: (json['distanceToStart'] as num).toDouble(),
      shipmentDistance: (json['shipmentDistance'] as num).toDouble(),
    );

Map<String, dynamic> _$SendToDriverRequestToJson(
  SendToDriverRequest instance,
) => <String, dynamic>{
  'driver_id': instance.driverId,
  'price': instance.price,
  'distanceToStart': instance.distanceToStart,
  'shipmentDistance': instance.shipmentDistance,
};
