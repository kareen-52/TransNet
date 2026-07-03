// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsModel _$PostDetailsModelFromJson(Map<String, dynamic> json) =>
    PostDetailsModel(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      weight: _stringFromJson(json['weight']),
      height: _stringFromJson(json['height']),
      width: _stringFromJson(json['width']),
      length: _stringFromJson(json['length']),
      object: json['object'] as String?,
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
      updatedAt: json['updated_at'] as String?,
      drivers: (json['drivers'] as List<dynamic>?)
          ?.map((e) => PostDriverOfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostDetailsModelToJson(PostDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'weight': instance.weight,
      'height': instance.height,
      'width': instance.width,
      'length': instance.length,
      'object': instance.object,
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
      'updated_at': instance.updatedAt,
      'drivers': instance.drivers,
    };

PostDriverOfferModel _$PostDriverOfferModelFromJson(
  Map<String, dynamic> json,
) => PostDriverOfferModel(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  rating: json['rating'] as num?,
  vehicle: json['vehicle'] as String?,
  date: json['date'] as String?,
  price: json['price'] as num?,
  badge: json['badge'] as String?,
  badgeText: json['badge_text'] as String?,
);

Map<String, dynamic> _$PostDriverOfferModelToJson(
  PostDriverOfferModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'rating': instance.rating,
  'vehicle': instance.vehicle,
  'date': instance.date,
  'price': instance.price,
  'badge': instance.badge,
  'badge_text': instance.badgeText,
};
