import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/route_geometry_entity.dart';
import 'package:latlong2/latlong.dart';

abstract class LatLngParser {
 
  static const zero = LatLng(0, 0);


  static LatLng parse(String? lat, String? lng) {
    if (lat == null || lng == null) return zero;
    try {
      return LatLng(double.parse(lat), double.parse(lng));
    } catch (_) {
      return zero;
    }
  }

  static List<LatLng> fromGeometry(RouteGeometryEntity? geometry) {
    if (geometry == null || geometry.isEmpty) return [];
    return geometry.coordinates
        .map((coord) => LatLng(coord[1], coord[0]))
        .toList();
  }
}
