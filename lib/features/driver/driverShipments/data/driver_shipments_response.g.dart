// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_shipments_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverShipmentsResponse _$DriverShipmentsResponseFromJson(
  Map<String, dynamic> json,
) => DriverShipmentsResponse(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ShipmentModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  currentPage: (json['current_page'] as num?)?.toInt(),
  lastPage: (json['last_page'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  perPage: (json['per_page'] as num?)?.toInt(),
  nextPageUrl: json['next_page_url'] as String?,
  prevPageUrl: json['prev_page_url'] as String?,
  firstPageUrl: json['first_page_url'] as String?,
  lastPageUrl: json['last_page_url'] as String?,
);

Map<String, dynamic> _$DriverShipmentsResponseToJson(
  DriverShipmentsResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'current_page': instance.currentPage,
  'last_page': instance.lastPage,
  'total': instance.total,
  'per_page': instance.perPage,
  'next_page_url': instance.nextPageUrl,
  'prev_page_url': instance.prevPageUrl,
  'first_page_url': instance.firstPageUrl,
  'last_page_url': instance.lastPageUrl,
};

ShipmentModel _$ShipmentModelFromJson(Map<String, dynamic> json) =>
    ShipmentModel(
      id: (json['id'] as num?)?.toInt(),
      shipmentNumber: (json['shipment_number'] as num?)?.toInt(),
      width: json['width'] as String?,
      height: json['height'] as String?,
      length: json['length'] as String?,
      weight: json['weight'] as String?,
      object: json['object'] as String?,
      price: (json['price'] as num?)?.toInt(),
      status: json['status'] as String?,
      success: (json['success'] as num?)?.toInt(),
      startGovernorate: json['start_governorate'] as String?,
      endGovernorate: json['end_governorate'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      driverId: (json['driver_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShipmentModelToJson(ShipmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'driver_id': instance.driverId,
      'shipment_number': instance.shipmentNumber,
      'width': instance.width,
      'height': instance.height,
      'length': instance.length,
      'weight': instance.weight,
      'object': instance.object,
      'price': instance.price,
      'status': instance.status,
      'success': instance.success,
      'start_governorate': instance.startGovernorate,
      'end_governorate': instance.endGovernorate,
    };
