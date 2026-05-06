import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapConstants {
  static const double minZoom = 10.0;
  static const double maxZoom = 18.0;

  static final Map<int, Map<String, dynamic>> governorateData = {
    1: { // دمشق
      'center': const LatLng(33.5138, 36.2765),
      'bounds': LatLngBounds(const LatLng(33.45, 36.22), const LatLng(33.56, 36.36)),
    },
    2: { // ريف دمشق
      'center': const LatLng(33.5000, 36.5000),
      'bounds': LatLngBounds(const LatLng(32.80, 35.80), const LatLng(34.20, 38.30)),
    },
    3: { // حلب
      'center': const LatLng(36.2012, 37.1612),
      'bounds': LatLngBounds(const LatLng(35.60, 36.60), const LatLng(36.90, 38.25)),
    },
    4: { // اللاذقية
      'center': const LatLng(35.5206, 35.7793),
      'bounds': LatLngBounds(const LatLng(35.15, 35.70), const LatLng(35.95, 36.25)),
    },
    5: { // حماة
      'center': const LatLng(35.1318, 36.7578),
      'bounds': LatLngBounds(const LatLng(34.80, 36.15), const LatLng(35.65, 38.00)),
    },
    6: { // حمص
      'center': const LatLng(34.7324, 36.7137),
      'bounds': LatLngBounds(const LatLng(33.80, 36.10), const LatLng(35.05, 39.65)),
    },
    7: { // درعا
      'center': const LatLng(32.6241, 36.1048),
      'bounds': LatLngBounds(const LatLng(32.50, 35.90), const LatLng(33.15, 36.35)),
    },
    8: { // القنيطرة
      'center': const LatLng(33.1256, 35.8215),
      'bounds': LatLngBounds(const LatLng(32.90, 35.75), const LatLng(33.25, 35.95)),
    },
    9: { // الرقة
      'center': const LatLng(35.9500, 39.0167),
      'bounds': LatLngBounds(const LatLng(35.25, 38.00), const LatLng(36.80, 39.80)),
    },
    10: { // دير الزور
      'center': const LatLng(35.3333, 40.1500),
      'bounds': LatLngBounds(const LatLng(34.30, 39.40), const LatLng(36.35, 41.50)),
    },
    11: { // الحسكة
      'center': const LatLng(36.5000, 40.7500),
      'bounds': LatLngBounds(const LatLng(35.75, 39.80), const LatLng(37.35, 42.40)),
    },
    12: { // إدلب
      'center': const LatLng(35.9306, 36.6339),
      'bounds': LatLngBounds(const LatLng(35.35, 36.15), const LatLng(36.30, 37.00)),
    },
    13: { // السويداء
      'center': const LatLng(32.7090, 36.5695),
      'bounds': LatLngBounds(const LatLng(32.35, 36.35), const LatLng(33.10, 36.90)),
    },
    14: { // طرطوس
      'center': const LatLng(34.8890, 35.8866),
      'bounds': LatLngBounds(const LatLng(34.50, 35.80), const LatLng(35.20, 36.30)),
    },
  };
}