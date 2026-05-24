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
