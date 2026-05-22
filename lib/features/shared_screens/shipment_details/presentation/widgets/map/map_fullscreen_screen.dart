import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/map/map_route_view.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/map/map_legend_bar.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/utils/lat_lng_parser.dart';
import 'package:latlong2/latlong.dart';

/// Full-screen interactive route preview.
/// Read-only from business perspective — no editing. Pan/zoom enabled.
class MapFullscreenScreen extends StatefulWidget {
  final List<LatLng> points;
  final LatLng start;
  final LatLng end;

  const MapFullscreenScreen({
    super.key,
    required this.points,
    required this.start,
    required this.end,
  });

  @override
  State<MapFullscreenScreen> createState() => _MapFullscreenScreenState();
}

class _MapFullscreenScreenState extends State<MapFullscreenScreen> {
  final MapController _mapController = MapController();

  void _fitBounds() {
    final all = [
      ...widget.points,
      if (widget.start != LatLngParser.zero) widget.start,
      if (widget.end != LatLngParser.zero) widget.end,
    ];
    if (all.isEmpty) return;
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: LatLngBounds.fromPoints(all),
        padding: EdgeInsets.all(48.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          MapRouteView(
            controller: _mapController,
            points: widget.points,
            start: widget.start,
            end: widget.end,
            interactive: true,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  _FloatingBtn(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  _FloatingBtn(
                    icon: Icons.fit_screen_rounded,
                    onTap: _fitBounds,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MapLegendBar(isDark: isDark),
          ),
        ],
      ),
    );
  }
}

class _FloatingBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _FloatingBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42.w,
        height: 42.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 20.sp, color: Colors.black87),
      ),
    );
  }
}
