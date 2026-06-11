import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/utils/lat_lng_parser.dart';
import 'package:latlong2/latlong.dart';


class MapRouteView extends StatelessWidget {
  final List<LatLng> points;
  final LatLng start;
  final LatLng end;
  final bool interactive;
  final MapController? controller;

  const MapRouteView({
    super.key,
    required this.points,
    required this.start,
    required this.end,
    required this.interactive,
    this.controller,
  });

  LatLng get _center {
    if (points.isNotEmpty) return points[points.length ~/ 2];
    if (start != LatLngParser.zero) return start;
    return end;
  }

  List<LatLng> get _routePoints {
    if (points.isNotEmpty) return points;
    return [start, end]
        .where((p) => p != LatLngParser.zero)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        initialCenter: _center,
        initialZoom: 12.0,
        minZoom: 8.0,
        maxZoom: 18.0,
        interactionOptions: InteractionOptions(
          flags: interactive
              ? InteractiveFlag.all & ~InteractiveFlag.rotate
              : InteractiveFlag.none,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.graduation_project',
          tileProvider: NetworkTileProvider(),
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: _routePoints,
              color: AppColors.primary,
              strokeWidth: 4.5,
              borderColor: Colors.white,
              borderStrokeWidth: 1.5,
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            if (start != LatLngParser.zero)
              Marker(
                point: start,
                width: 36.w,
                height: 36.w,
                child: _RouteMarker(color: AppColors.success),
              ),
            if (end != LatLngParser.zero)
              Marker(
                point: end,
                width: 36.w,
                height: 36.w,
                child: _RouteMarker(color: AppColors.error),
              ),
          ],
        ),
      ],
    );
  }
}



class _RouteMarker extends StatelessWidget {
  final Color color;
  const _RouteMarker({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.50),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(Icons.circle, color: Colors.white, size: 10.sp),
    );
  }
}
