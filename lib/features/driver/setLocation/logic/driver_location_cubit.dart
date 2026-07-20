import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/setLocation/data/models/driver_set_location_request.dart';
import 'package:graduation_progect/features/driver/setLocation/data/repo/driver_location_repo.dart';
import 'driver_location_state.dart';

class DriverLocationCubit extends Cubit<DriverLocationState> {
  final DriverLocationRepo _repo;
  StreamSubscription<Position>? _positionStream;
  Timer? _hourlyTimer;
  DateTime? _lastSentTime;
  static const Duration _throttleDuration = Duration(seconds: 2);

  DriverLocationCubit(this._repo) : super(const DriverLocationState.initial());

  void toggleLocationTracking(bool isAvailable) async {
    if (isAvailable) {
      await _startTracking();
    } else {
      await _stopTracking();
    }
  }

  Future<void> _startTracking() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

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

    final currentPosition = await Geolocator.getCurrentPosition();
    _sendLocationWithThrottle(
      currentPosition.latitude,
      currentPosition.longitude,
    );

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
