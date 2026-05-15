// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentDetailsResponse _$ShipmentDetailsResponseFromJson(
  Map<String, dynamic> json,
) => ShipmentDetailsResponse(
  shipment: ShipmentDetail.fromJson(json['shipment'] as Map<String, dynamic>),
  route_geometry: json['route_geometry'] == null
      ? null
      : RouteGeometry.fromJson(json['route_geometry'] as Map<String, dynamic>),
  live_tracking: json['live_tracking'],
  driver: json['driver'] == null
      ? null
      : PartyInfo.fromJson(json['driver'] as Map<String, dynamic>),
  client: json['client'] == null
      ? null
      : PartyInfo.fromJson(json['client'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ShipmentDetailsResponseToJson(
  ShipmentDetailsResponse instance,
) => <String, dynamic>{
  'shipment': instance.shipment,
  'route_geometry': instance.route_geometry,
  'live_tracking': instance.live_tracking,
  'driver': instance.driver,
  'client': instance.client,
};

ShipmentDetail _$ShipmentDetailFromJson(Map<String, dynamic> json) =>
    ShipmentDetail(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      driverId: (json['driver_id'] as num?)?.toInt(),
      shipmentNumber: (json['shipment_number'] as num).toInt(),
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
      price: (json['price'] as num?)?.toInt(),
      status: json['status'] as String?,
      success: (json['success'] as num?)?.toInt(),
      deliveryDeadline: json['delivery_deadline'] as String?,
      paid: (json['paid'] as num?)?.toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      startGovernorate: json['start_governorate'] as String,
      endGovernorate: json['end_governorate'] as String,
      pin: json['pin'] as String?,
      qrPin: json['qr_pin'] as String?,
    );

Map<String, dynamic> _$ShipmentDetailToJson(ShipmentDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'driver_id': instance.driverId,
      'shipment_number': instance.shipmentNumber,
      'pin': instance.pin,
      'qr_pin': instance.qrPin,
      'created_at': instance.createdAt,
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
      'price': instance.price,
      'status': instance.status,
      'success': instance.success,
      'delivery_deadline': instance.deliveryDeadline,
      'paid': instance.paid,
      'updated_at': instance.updatedAt,
      'start_governorate': instance.startGovernorate,
      'end_governorate': instance.endGovernorate,
    };

RouteGeometry _$RouteGeometryFromJson(Map<String, dynamic> json) =>
    RouteGeometry(
      coordinates: (json['coordinates'] as List<dynamic>)
          .map(
            (e) =>
                (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
          )
          .toList(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$RouteGeometryToJson(RouteGeometry instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
      'type': instance.type,
    };

PartyInfo _$PartyInfoFromJson(Map<String, dynamic> json) => PartyInfo(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  phoneNumber: json['phone_number'] as String,
  userNumber: json['user_number'] as String,
);

Map<String, dynamic> _$PartyInfoToJson(PartyInfo instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone_number': instance.phoneNumber,
  'user_number': instance.userNumber,
};