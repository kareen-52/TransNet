import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/instant_orders/data/models/respond_response_model.dart';

class DriverTrackingScreen extends StatefulWidget {
  final ShipmentMapData mapData;

  const DriverTrackingScreen({super.key, required this.mapData});

  @override
  State<DriverTrackingScreen> createState() => _DriverTrackingScreenState();
}

class _DriverTrackingScreenState extends State<DriverTrackingScreen> {
  LatLng? _driverCurrentLocation;
  final MapController _mapController = MapController();
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // يمكنك عرض ديالوج للمستخدم هنا
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _driverCurrentLocation = LatLng(position.latitude, position.longitude);
        _isLoadingLocation = false;
      });

      // تحريك الكاميرا لموقع السائق عند تحميله
      _mapController.move(_driverCurrentLocation!, 14.0);
    } catch (e) {
      setState(() => _isLoadingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final startPoint = LatLng(widget.mapData.startLat, widget.mapData.startLng);
    final endPoint = LatLng(widget.mapData.endLat, widget.mapData.endLng);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تتبع مسار الشحنة'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              // المركز المبدئي هو نقطة انطلاق الشحنة
              initialCenter: startPoint,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.graduation_progect',
              ),
              
              // رسم المسار (الخط)
              if (widget.mapData.pathCoordinates.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: widget.mapData.pathCoordinates,
                      strokeWidth: 5.0,
                      color: AppColors.primary, // أو اللون المفضل لديك
                    ),
                  ],
                ),

              // رسم العلامات (البداية، النهاية، موقع السائق)
              MarkerLayer(
                markers: [
                  // علامة نقطة الانطلاق
                  Marker(
                    point: startPoint,
                    width: 40.w,
                    height: 40.h,
                    child: const Icon(Icons.location_on, color: Colors.green, size: 40),
                  ),
                  // علامة نقطة النهاية
                  Marker(
                    point: endPoint,
                    width: 40.w,
                    height: 40.h,
                    child: const Icon(Icons.flag, color: Colors.red, size: 40),
                  ),
                  // علامة السائق (إذا تم تحديد موقعه)
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
                        child: const Icon(Icons.local_shipping, color: Colors.blue, size: 30),
                      ),
                    ),
                ],
              ),
            ],
          ),

          // مؤشر التحميل ريثما يتم جلب موقع السائق
          if (_isLoadingLocation)
            const Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            
          // زر للعودة لموقع السائق
          Positioned(
            bottom: 30.h,
            right: 20.w,
            child: FloatingActionButton(
              onPressed: () {
                if (_driverCurrentLocation != null) {
                  _mapController.move(_driverCurrentLocation!, 15.0);
                } else {
                  _getCurrentLocation();
                }
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Icon(Icons.my_location, color: Theme.of(context).colorScheme.primary),
            ),
          )
        ],
      ),
    );
  }
}