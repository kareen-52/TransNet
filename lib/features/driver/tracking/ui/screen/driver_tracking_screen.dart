import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/features/shared_screens/map/logic/data/map_service.dart';
import 'package:graduation_progect/features/shared_screens/map/ui/widgets/my_location_button.dart';
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
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() {
          _driverCurrentLocation = LatLng(
            position.latitude,
            position.longitude,
          );
        });
        _mapController.move(_driverCurrentLocation!, 14.0);
      }
    } catch (e) {    }
  }

  @override
  Widget build(BuildContext context) {
    final startPoint = LatLng(
      widget.shipment.startLat,
      widget.shipment.startLng,
    );
    final endPoint = LatLng(widget.shipment.endLat, widget.shipment.endLng);

    return Scaffold(
      appBar: AppBar(
        title: Text('تتبع الشحنة '),
        centerTitle: true,
      ),
      body: Stack(
        children: [

          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialCenter: startPoint, initialZoom: 13.0),
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: startPoint,
                    width: 30.w,
                    height: 30.h,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                  Marker(
                    point: endPoint,
                    width: 30.w,
                    height: 30.h,
                    child: const Icon(Icons.flag, color: Colors.red, size: 40),
                  ),
                  if (_driverCurrentLocation != null)
                    Marker(
                      point: _driverCurrentLocation!,
                      width: 50.w,
                      height: 50.h,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withOpacity(0.3),
                        ),
                        child: const Icon(
                          Icons.local_shipping,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),


          Positioned(
            top: 20.h,
            right: 20.w,
            child: MyLocationButton(
              mapService: getIt<MapService>(),
              onLocationFetched: (latLng) {
                _mapController.move(latLng, 15.0);
              },
            ),
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: TrackingBottomSheet(initialShipment: widget.shipment),
          ),
        ],
      ),
    );
  }
}
