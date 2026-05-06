import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/networking/api_constants.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';
import 'package:graduation_progect/features/shared_screens/map/data/map_constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:graduation_progect/features/shared_screens/map/logic/data/map_service.dart';
import '../widgets/map_search_box.dart';
import '../widgets/my_location_button.dart';

class PickLocationScreen extends StatefulWidget {
  final LatLng initialLocation;
  final String title;
  final String expectedGovernorate;
  final LatLngBounds? governorateBounds;

  const PickLocationScreen({
    super.key,
    required this.initialLocation,
    required this.title,
    required this.expectedGovernorate,
    this.governorateBounds,
  });

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  final MapController _mapController = MapController();
  final MapService _mapService = MapService();
  late StreamSubscription _mapEventSubscription;

  late LatLng _currentCenter;
  bool _isMoving = false;

  String _currentAddress = "جاري تحديد الموقع...";
  bool _isFetchingAddress = false;

  @override
  void initState() {
    super.initState();
    _currentCenter = widget.initialLocation;

    _mapEventSubscription = _mapController.mapEventStream.listen((event) {
      if (event is MapEventMoveStart) {
        if (!_isMoving) setState(() => _isMoving = true);
      } else if (event is MapEventMoveEnd) {
        if (_isMoving) setState(() => _isMoving = false);
        _fetchAddressForCenter(_currentCenter);
      }
    });

    _fetchAddressForCenter(_currentCenter);
  }

  @override
  void dispose() {
    _mapEventSubscription.cancel();
    super.dispose();
  }

  void _fetchAddressForCenter(LatLng position) async {
    if (_isFetchingAddress) return;

    setState(() => _isFetchingAddress = true);
    final result = await _mapService.getAddressFromLatLng(position);
    if (mounted) {
      setState(() {
        _isFetchingAddress = false;
        if (result != null) {
          List<String> addressParts = result['display_name']!.split(',');
          _currentAddress = addressParts.take(2).join(', ');
        } else {
          _currentAddress = "موقع غير معروف";
        }
      });
    }
  }


  void _showOutOfBoundsDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            horizontalSpace(8),
            Text('تنبيه', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        content: Text(message, style: Theme.of(context).textTheme.bodyLarge),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'حسناً',
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


  void _moveToLocation(LatLng newLocation) {
    if (widget.governorateBounds != null &&
        !widget.governorateBounds!.contains(newLocation)) {
      _showOutOfBoundsDialog(
        'الموقع الذي تحاول تحديده يقع خارج نطاق محافظة ${widget.expectedGovernorate}. يرجى اختيار موقع داخل المحافظة.',
      );
    } else {
      setState(() => _currentCenter = newLocation);
      _mapController.move(newLocation, 15.0);
      _fetchAddressForCenter(newLocation);
    }
  }



  void _confirmLocation() {
    if (widget.governorateBounds != null &&
        !widget.governorateBounds!.contains(_currentCenter)) {
      _showOutOfBoundsDialog(
        'عذراً، يجب اختيار موقع يقع تماماً داخل حدود محافظة ${widget.expectedGovernorate}.',
      );
      return;
    }
    Navigator.pop(context, _currentCenter);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.title} (${widget.expectedGovernorate})',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.initialLocation,
              initialZoom: 15.0,
              minZoom: MapConstants.minZoom,
              maxZoom: MapConstants.maxZoom,

              cameraConstraint: widget.governorateBounds != null
                  ? CameraConstraint.contain(bounds: widget.governorateBounds!)
                  : const CameraConstraint.unconstrained(),
              onPositionChanged: (position, hasGesture) {
                if (hasGesture) {
                  setState(() => _currentCenter = position.center);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: ApiConstants.mapUrl,
                userAgentPackageName: ApiConstants.userAgent,
              ),
            ],
          ),

          IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              margin: EdgeInsets.only(bottom: _isMoving ? 80.h : 40.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    color: theme.colorScheme.error,
                    size: 50.sp,
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _isMoving ? 0.2 : 0.6,
                    child: Container(
                      width: 15.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 16.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              children: [
                MapSearchWidget(
                  mapService: _mapService,
                  onPlaceSelected: _moveToLocation,
                  expectedGovernorate: widget.expectedGovernorate,
                  governorateBounds:
                      widget.governorateBounds,
                ),
                verticalSpace(16),
                CustomShadowCard(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      _isFetchingAddress
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.primary,
                              ),
                            )
                          : Icon(Icons.place, color: theme.colorScheme.primary),
                      horizontalSpace(12),
                      Expanded(
                        child: Text(
                          _currentAddress,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 120.h,
            right: 20.w,
            child: MyLocationButton(
              mapService: _mapService,
              onLocationFetched: _moveToLocation,
              expectedBounds: widget.governorateBounds,
              expectedGovernorate: widget.expectedGovernorate,
            ),
          ),

          Positioned(
            bottom: 60.h,
            left: 20.w,
            right: 20.w,
            child: AppTextButton(
              text: 'تأكيد هذا الموقع',
              backgroundColor: theme.colorScheme.primary,
              onPressed: _confirmLocation,
            ),
          ),
        ],
      ),
    );
  }
}
