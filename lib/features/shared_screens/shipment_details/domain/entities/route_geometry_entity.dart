/// Domain entity representing the decoded route geometry for a shipment.
/// Holds the ordered list of [lng, lat] coordinate pairs that form the route.
class RouteGeometryEntity {
  final List<List<double>> coordinates;
  final String type;

  const RouteGeometryEntity({
    required this.coordinates,
    required this.type,
  });

  bool get isEmpty => coordinates.isEmpty;
  bool get isNotEmpty => coordinates.isNotEmpty;
}
