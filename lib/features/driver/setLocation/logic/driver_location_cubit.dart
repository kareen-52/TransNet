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
  StreamSubscription<ServiceStatus>? _serviceStatusStream;
  Timer? _hourlyTimer;
  DateTime? _lastSentTime;
  static const Duration _throttleDuration = Duration(seconds: 2);

  final StreamController<void> _locationServiceDisabledController = StreamController<void>.broadcast();
  Stream<void> get onLocationServiceDisabled => _locationServiceDisabledController.stream;


  DriverLocationCubit(this._repo) : super(const DriverLocationState.initial());


  Future<LocationPermissionCheckResult> ensureLocationPermissionGranted() async {

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return LocationPermissionCheckResult.serviceDisabled;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {

      return LocationPermissionCheckResult.deniedForever;
    }

    if (permission == LocationPermission.denied) {
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
    _serviceStatusStream?.cancel();
    _serviceStatusStream = Geolocator.getServiceStatusStream().listen((
      ServiceStatus status,
    ) {
      if (status == ServiceStatus.disabled) {
        _onLocationServiceDisabled();
      }
    });
  }

  Future<void> _onLocationServiceDisabled() async {
    await _stopTracking();
    if (!_locationServiceDisabledController.isClosed) {
      _locationServiceDisabledController.add(null);
    }
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
    await _serviceStatusStream?.cancel();
    _serviceStatusStream = null;
    _hourlyTimer?.cancel();
    _hourlyTimer = null;
  }

  @override
  Future<void> close() {
    _positionStream?.cancel();
    _serviceStatusStream?.cancel();
    _hourlyTimer?.cancel();
    _locationServiceDisabledController.close();
    return super.close();
  }
}
