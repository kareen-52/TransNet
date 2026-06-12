import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/route_geometry_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/map/map_fullscreen_screen.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/map/map_route_view.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/utils/lat_lng_parser.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/map/map_no_route_card.dart';
import 'package:latlong2/latlong.dart';

class ShipmentMapCard extends StatelessWidget {
  final RouteGeometryEntity? routeGeometry;
  final ShipmentEntity shipment;
  final bool isDark;

  const ShipmentMapCard({
    super.key,
    this.routeGeometry,
    required this.shipment,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final points = LatLngParser.fromGeometry(routeGeometry);
    final start = LatLngParser.parse(
        shipment.startPositionLat, shipment.startPositionLng);
    final end =
        LatLngParser.parse(shipment.endPositionLat, shipment.endPositionLng);
    final hasRoute = points.isNotEmpty ||
        start != LatLngParser.zero ||
        end != LatLngParser.zero;

    if (!hasRoute) return MapNoRouteCard(isDark: isDark);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              MapFullscreenScreen(points: points, start: start, end: end),
          transitionsBuilder: (_, anim, __, child) => SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(0, 1), end: Offset.zero)
                .animate(CurvedAnimation(
                    parent: anim, curve: Curves.easeOutCubic)),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 320),
        ));
      },
      child: _MapPreviewCard(
          points: points, start: start, end: end, isDark: isDark),
    );
  }
}

class _MapPreviewCard extends StatelessWidget {
  final List<LatLng> points;
  final LatLng start;
  final LatLng end;
  final bool isDark;

  const _MapPreviewCard(
      {required this.points,
      required this.start,
      required this.end,
      required this.isDark});

  @override
  Widget build(BuildContext context) {
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.22 : 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: MapRouteView(
                points: points, start: start, end: end, interactive: false),
          ),

          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.45),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 12.h,
            left: 12.w,
            right: 12.w,
            child: Row(
              children: [
                _MapChip(icon: Icons.fullscreen_rounded, label: 'عرض الخريطة كاملة'),
                const Spacer(),
                if (points.isNotEmpty)
                  _MapChip(icon: Icons.route_rounded, label: 'خط الرحلة'),
              ],
            ),
          ),

          Positioned(
            top: 10.h,
            right: 10.w,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.40),
                      blurRadius: 8),
                ],
              ),
              child: Icon(Icons.map_rounded, color: Colors.white, size: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MapChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.50),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 12.sp),
          SizedBox(width: 4.w),
          Text(label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}


