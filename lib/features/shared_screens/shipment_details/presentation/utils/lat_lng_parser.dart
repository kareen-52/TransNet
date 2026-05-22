import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/route_geometry_entity.dart';
import 'package:latlong2/latlong.dart';

/// Utility class for converting raw shipment coordinate data into
/// [LatLng] objects used by the map layer.
///
/// Centralises all coordinate parsing so map widgets remain free
/// of raw string/list manipulation.
abstract class LatLngParser {
  /// Sentinel value representing an invalid or absent coordinate.
  static const zero = LatLng(0, 0);

  /// Safely parses a latitude/longitude string pair.
  /// Returns [zero] if either value is null or cannot be parsed.
  static LatLng parse(String? lat, String? lng) {
    if (lat == null || lng == null) return zero;
    try {
      return LatLng(double.parse(lat), double.parse(lng));
    } catch (_) {
      return zero;
    }
  }

  /// Converts a [RouteGeometryEntity] coordinate list (GeoJSON format:
  /// `[longitude, latitude]`) into an ordered list of [LatLng] objects.
  ///
  /// Returns an empty list when [geometry] is null or empty.
  static List<LatLng> fromGeometry(RouteGeometryEntity? geometry) {
    if (geometry == null || geometry.isEmpty) return [];
    return geometry.coordinates
        .map((coord) => LatLng(coord[1], coord[0]))
        .toList();
  }
}
