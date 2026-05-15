import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/data/models/active_driver_shipment_model.dart';
import 'package:graduation_progect/features/driver/tracking/ui/widgets/tracking_bottom_sheet.dart';

class DriverTrackingScreen extends StatefulWidget {
  final ActiveDriverShipmentModel shipment;

  const DriverTrackingScreen({super.key, required this.shipment});

  @override
  State<DriverTrackingScreen> createState() => _DriverTrackingScreenState();
}

class _DriverTrackingScreenState extends State<DriverTrackingScreen> {
  LatLng? _driverCurrentLocation;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (mounted) {
        setState(() {
          _driverCurrentLocation = LatLng(position.latitude, position.longitude);
        });
        _mapController.move(_driverCurrentLocation!, 14.0);
      }
    } catch (e) {
      // Ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    final startPoint = LatLng(widget.shipment.startLat, widget.shipment.startLng);
    final endPoint = LatLng(widget.shipment.endLat, widget.shipment.endLng);

    return Scaffold(
      appBar: AppBar(
        title: Text('تتبع الشحنة #${widget.shipment.shipmentNumber}'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 1. الخريطة المباشرة
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: startPoint,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.graduation_progect',
              ),
              if (widget.shipment.pathCoordinates.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: widget.shipment.pathCoordinates,
                      strokeWidth: 5.0,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  Marker(point: startPoint, width: 40.w, height: 40.h, child: const Icon(Icons.location_on, color: Colors.green, size: 40)),
                  Marker(point: endPoint, width: 40.w, height: 40.h, child: const Icon(Icons.flag, color: Colors.red, size: 40)),
                  if (_driverCurrentLocation != null)
                    Marker(
                      point: _driverCurrentLocation!,
                      width: 50.w,
                      height: 50.h,
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.withOpacity(0.3)),
                        child: const Icon(Icons.local_shipping, color: Colors.blue, size: 30),
                      ),
                    ),
                ],
              ),
            ],
          ),

          // زر التمركز
          Positioned(
            top: 20.h,
            right: 20.w,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Theme.of(context).colorScheme.surface,
              onPressed: () {
                if (_driverCurrentLocation != null) _mapController.move(_driverCurrentLocation!, 15.0);
              },
              child: Icon(Icons.my_location, color: Theme.of(context).colorScheme.primary),
            ),
          ),

          // 2. القسم السفلي الذكي (التفاصيل + الأزرار)
          Align(
            alignment: Alignment.bottomCenter,
            child: TrackingBottomSheet(initialShipment: widget.shipment),
          ),
        ],
      ),
    );
  }
}