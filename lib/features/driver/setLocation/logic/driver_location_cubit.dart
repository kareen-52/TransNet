import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/setLocation/data/models/driver_set_location_request.dart';
import 'package:graduation_progect/features/driver/setLocation/data/repo/driver_location_repo.dart';
import 'driver_location_state.dart';

enum LocationPermissionCheckResult {
  granted,
  serviceDisabled,
  deniedForever,
  denied,
}

class DriverLocationCubit extends Cubit<DriverLocationState> {
  final DriverLocationRepo _repo;
  StreamSubscription<Position>? _positionStream;
  Timer? _hourlyTimer;
  DateTime? _lastSentTime;
  static const Duration _throttleDuration = Duration(seconds: 2);

  DriverLocationCubit(this._repo) : super(const DriverLocationState.initial());

  /// يتحقق من صلاحية الموقع فقط (بدون بدء أي تتبع)، ويطلبها إذا كانت مرفوضة.
  /// يجب استدعاؤها ومعرفة نتيجتها *قبل* تفعيل حالة "متاح"،
  /// حتى لا يصبح السائق متاحاً بدون صلاحية موقع فعلية.
  Future<LocationPermissionCheckResult> ensureLocationPermissionGranted() async {
    // تحقق أولاً أن خدمة الموقع (GPS) نفسها مفعّلة على الجهاز
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return LocationPermissionCheckResult.serviceDisabled;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      // المستخدم رفض نهائياً - النظام ما بيسمح بديالوج تاني، لازم إعدادات التطبيق
      return LocationPermissionCheckResult.deniedForever;
    }

    if (permission == LocationPermission.denied) {
      // هون رح يطلع ديالوج النظام الأصلي (Allow/Deny) تلقائياً
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return LocationPermissionCheckResult.granted;
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationPermissionCheckResult.deniedForever;
    }

    return LocationPermissionCheckResult.denied;
  }

  void toggleLocationTracking(bool isAvailable) async {
    if (isAvailable) {
      await _startTracking();
    } else {
      await _stopTracking();
    }
  }

  Future<void> _startTracking() async {
    // ملاحظة: الصلاحية يُفترض أنها متحقّقة مسبقاً عبر ensureLocationPermissionGranted()
    // (تُستدعى من AvailabilityToggle قبل تفعيل "متاح"). هنا فقط نبدأ التتبع الفعلي،
    // ونطلب الموقع الحالي *مرة واحدة فقط* لتفادي ظهور Dialog دقة الموقع مرتين.
    final currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
    _sendLocationWithThrottle(
      currentPosition.latitude,
      currentPosition.longitude,
    );

    _positionStream =
        Geolocator.getPositionStream(
          locationSettings: AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 15,
            intervalDuration: const Duration(seconds: 1),
          ),
        ).listen((Position position) {
          _sendLocationWithThrottle(position.latitude, position.longitude);
        });

    _hourlyTimer?.cancel();
    _hourlyTimer = Timer.periodic(Duration(hours: 1), (timer) async {
      final pos = await Geolocator.getCurrentPosition();
      _sendLocationWithThrottle(pos.latitude, pos.longitude);
    });
  }

  Future<void> _sendLocationWithThrottle(double lat, double lng) async {
    final now = DateTime.now();
    if (_lastSentTime != null &&
        now.difference(_lastSentTime!) < _throttleDuration) {
      return;
    }
    _lastSentTime = now;
    await _sendLocationToApi(lat, lng);
  }

  Future<void> _sendLocationToApi(double lat, double lng) async {
    final response = await _repo.setLocation(
      DriverSetLocationRequest(lat: lat, lng: lng),
    );
    response.when(
      success: (data) => emit(DriverLocationState.success(data.message ?? "")),
      failure: (error) => emit(DriverLocationState.error(error)),
    );
  }

  Future<void> _stopTracking() async {
    await _positionStream?.cancel();
    _positionStream = null;
    _hourlyTimer?.cancel();
    _hourlyTimer = null;
  }

  @override
  Future<void> close() {
    _positionStream?.cancel();
    _hourlyTimer?.cancel();
    return super.close();
  }
}
