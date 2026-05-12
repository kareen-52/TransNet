// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActiveOrderModel _$ActiveOrderModelFromJson(Map<String, dynamic> json) =>
    _ActiveOrderModel(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      driverId: (json['driver_id'] as num).toInt(),
      shipmentNumber: (json['shipment_number'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      status: json['status'] as String,
      driver: ActiveOrderDriverModel.fromJson(
        json['driver'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ActiveOrderModelToJson(_ActiveOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'driver_id': instance.driverId,
      'shipment_number': instance.shipmentNumber,
      'price': instance.price,
      'status': instance.status,
      'driver': instance.driver,
    };

_ActiveOrderDriverModel _$ActiveOrderDriverModelFromJson(
  Map<String, dynamic> json,
) => _ActiveOrderDriverModel(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  phoneNumber: json['phone_number'] as String,
  userNumber: json['user_number'] as String,
);

Map<String, dynamic> _$ActiveOrderDriverModelToJson(
  _ActiveOrderDriverModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone_number': instance.phoneNumber,
  'user_number': instance.userNumber,
};
