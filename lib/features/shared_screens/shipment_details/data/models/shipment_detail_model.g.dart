// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentDetailModel _$ShipmentDetailModelFromJson(Map<String, dynamic> json) =>
    ShipmentDetailModel(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      driverId: (json['driver_id'] as num?)?.toInt(),
      shipmentNumber: (json['shipment_number'] as num).toInt(),
      pin: json['pin'] as String?,
      qrPin: json['qr_pin'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      weight: json['weight'] as String?,
      height: json['height'] as String?,
      width: json['width'] as String?,
      length: json['length'] as String?,
      object: json['object'] as String?,
      insurance: (json['insurance'] as num?)?.toInt(),
      startPositionLat: json['start_position_lat'] as String,
      startPositionLng: json['start_position_lng'] as String,
      endPositionLat: json['end_position_lat'] as String,
      endPositionLng: json['end_position_lng'] as String,
      startGovernorate: json['start_governorate'] as String,
      endGovernorate: json['end_governorate'] as String,
      price: (json['price'] as num?)?.toInt(),
      status: json['status'] as String?,
      success: (json['success'] as num?)?.toInt(),
      deliveryDeadline: json['delivery_deadline'] as String?,
    );

Map<String, dynamic> _$ShipmentDetailModelToJson(
  ShipmentDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'driver_id': instance.driverId,
  'shipment_number': instance.shipmentNumber,
  'pin': instance.pin,
  'qr_pin': instance.qrPin,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
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
  'start_governorate': instance.startGovernorate,
  'end_governorate': instance.endGovernorate,
  'price': instance.price,
  'status': instance.status,
  'success': instance.success,
  'delivery_deadline': instance.deliveryDeadline,
};
