// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  weight: _stringFromJson(json['weight']),
  height: _stringFromJson(json['height']),
  width: _stringFromJson(json['width']),
  length: _stringFromJson(json['length']),
  object: json['object'] as String?,
  insurance: (json['insurance'] as num?)?.toInt(),
  startPositionLat: _stringFromJson(json['start_position_lat']),
  startPositionLng: _stringFromJson(json['start_position_lng']),
  endPositionLat: _stringFromJson(json['end_position_lat']),
  endPositionLng: _stringFromJson(json['end_position_lng']),
  startLocationDetails: json['start_location_details'] as String?,
  endLocationDetails: json['end_location_details'] as String?,
  maxPrice: json['max_price'] as num?,
  minPrice: json['min_price'] as num?,
  lastDate: json['last_date'] as String?,
  finished: (json['finished'] as num?)?.toInt(),
  startGovernorate: json['start_governorate'] as String?,
  endGovernorate: json['end_governorate'] as String?,
  createdAt: json['created_at'] as String?,
  myPrice: json['my_price'] as num?,
  myDate: json['my_date'] as String?,
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
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
  'start_location_details': instance.startLocationDetails,
  'end_location_details': instance.endLocationDetails,
  'max_price': instance.maxPrice,
  'min_price': instance.minPrice,
  'last_date': instance.lastDate,
  'finished': instance.finished,
  'start_governorate': instance.startGovernorate,
  'end_governorate': instance.endGovernorate,
  'created_at': instance.createdAt,
  'my_price': instance.myPrice,
  'my_date': instance.myDate,
};
