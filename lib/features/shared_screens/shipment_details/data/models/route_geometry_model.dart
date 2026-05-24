import 'package:json_annotation/json_annotation.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/route_geometry_entity.dart';

part 'route_geometry_model.g.dart';

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

  
  RouteGeometryEntity toEntity() => RouteGeometryEntity(
        coordinates: coordinates,
        type: type,
      );
}
