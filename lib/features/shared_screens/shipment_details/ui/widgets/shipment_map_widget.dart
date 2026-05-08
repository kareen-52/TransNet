import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/models/shipment_details_response.dart';

class ShipmentMapWidget extends StatelessWidget {
  final RouteGeometry? geometry;
  final String? startLat;
  final String? startLng;
  final String? endLat;
  final String? endLng;

  const ShipmentMapWidget({
    Key? key,
    this.geometry,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<LatLng> points = _convertToLatLng(geometry?.coordinates);
    final LatLng startPoint = _parseLatLng(startLat, startLng);
    final LatLng endPoint = _parseLatLng(endLat, endLng);

    // إذا لم توجد أي نقاط ولا نقطة بداية ولا نقطة نهاية
    if (points.isEmpty && startPoint == const LatLng(0, 0) && endPoint == const LatLng(0, 0)) {
      return Container(
        height: 200.h,
        width: double.infinity,
        color: Colors.grey.shade100,
        child: const Center(child: Text('لا يوجد مسار متاح')),
      );
    }

    // تحديد مركز الخريطة
    LatLng center;
    if (points.isNotEmpty) {
      center = points[points.length ~/ 2];
    } else if (startPoint != const LatLng(0, 0)) {
      center = startPoint;
    } else {
      center = endPoint;
    }

    return SizedBox(
      height: 250.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: FlutterMap(
          options: MapOptions(
            // center: center,
            // zoom: 13.0,
            minZoom: 10.0,
            maxZoom: 18.0,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.pinchZoom | InteractiveFlag.doubleTapZoom,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.graduation_project',
            ),
            // إذا كانت points فارغة، ارسم خطاً وهمياً بين start و end
            PolylineLayer(
              polylines: [
                Polyline(
                  points: points.isNotEmpty ? points : [startPoint, endPoint],
                  color: Colors.blue,
                  strokeWidth: 5,
                  borderColor: Colors.white,
                  borderStrokeWidth: 2,
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                if (startPoint != const LatLng(0, 0))
                  Marker(
                    point: startPoint,
                    width: 40.w,
                    height: 40.w,
                    child: const Icon(Icons.location_on, color: Colors.green, size: 40),
                  ),
                if (endPoint != const LatLng(0, 0))
                  Marker(
                    point: endPoint,
                    width: 40.w,
                    height: 40.w,
                    child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<LatLng> _convertToLatLng(List<List<double>>? coords) {
    if (coords == null) return [];
    return coords.map((c) => LatLng(c[1], c[0])).toList();
  }

  LatLng _parseLatLng(String? lat, String? lng) {
    if (lat == null || lng == null) return const LatLng(0, 0);
    try {
      return LatLng(double.parse(lat), double.parse(lng));
    } catch (_) {
      return const LatLng(0, 0);
    }
  }
}