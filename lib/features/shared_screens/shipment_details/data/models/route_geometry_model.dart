import 'package:json_annotation/json_annotation.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/route_geometry_entity.dart';

part 'route_geometry_model.g.dart';

/// Data model for route geometry (GeoJSON LineString).
/// Responsible only for JSON deserialization and entity mapping.
@JsonSerializable()
class RouteGeometryModel {
  final List<List<double>> coordinates;
  final String type;

  const RouteGeometryModel({
    required this.coordinates,
    required this.type,
  });

  factory RouteGeometryModel.fromJson(Map<String, dynamic> json) =>
      _$RouteGeometryModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteGeometryModelToJson(this);

  /// Maps this data model to the corresponding domain entity.
  RouteGeometryEntity toEntity() => RouteGeometryEntity(
        coordinates: coordinates,
        type: type,
      );
}
