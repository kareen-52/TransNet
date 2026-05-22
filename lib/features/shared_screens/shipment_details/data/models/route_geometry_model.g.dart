// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_geometry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteGeometryModel _$RouteGeometryModelFromJson(Map<String, dynamic> json) =>
    RouteGeometryModel(
      coordinates: (json['coordinates'] as List<dynamic>)
          .map(
            (e) =>
                (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
          )
          .toList(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$RouteGeometryModelToJson(RouteGeometryModel instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
      'type': instance.type,
    };
