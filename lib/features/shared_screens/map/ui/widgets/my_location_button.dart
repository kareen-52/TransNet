import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/features/shared_screens/map/logic/data/map_service.dart';
import 'package:latlong2/latlong.dart';

class MyLocationButton extends StatefulWidget {
  final MapService mapService;
  final Function(LatLng) onLocationFetched;
  final LatLngBounds? expectedBounds;
  final String expectedGovernorate;

  const MyLocationButton({
    super.key,
    required this.mapService,
    required this.onLocationFetched,
    this.expectedBounds,
    this.expectedGovernorate = '',
  });

  @override
  State<MyLocationButton> createState() => _MyLocationButtonState();
}

class _MyLocationButtonState extends State<MyLocationButton> {
  bool _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.location_off,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(width: 8.w),
            Text('عذراً', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        content: Text(message, style: Theme.of(context).textTheme.bodyLarge),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'موافق',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  

  Future<void> _fetchAndGoToMyLocation() async {
    setState(() => _isLoading = true);

    final myLocation = await widget.mapService.getUserCurrentLocation();

    if (mounted) {
      setState(() => _isLoading = false);
      if (myLocation != null) {
        if (widget.expectedBounds != null &&
            !widget.expectedBounds!.contains(myLocation)) {
          _showErrorDialog(
            'موقعك الحالي يقع خارج نطاق محافظة ${widget.expectedGovernorate}. يرجى تحديد موقع يدوياً داخل المحافظة.',
          );
        } else {
          widget.onLocationFetched(myLocation);
        }
      } else {
        _showErrorDialog(
          'تعذر الوصول لموقعك، يرجى تفعيل إعدادات الـ GPS في جهازك.',
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FloatingActionButton(
      heroTag: "btn_my_location",
      mini: true,
      backgroundColor: theme.colorScheme.surface,
      onPressed: _isLoading ? null : _fetchAndGoToMyLocation,
      child: _isLoading
          ? Padding(
              padding: EdgeInsets.all(10.sp),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            )
          : Icon(Icons.my_location, color: theme.colorScheme.primary),
    );
  }
}
