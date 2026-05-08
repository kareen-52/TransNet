import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/home/data/repo/home_driver_repo.dart';
import 'package:graduation_progect/features/driver/home/logic/driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  final DriverHomeRepo _driverHomeRepo;

  bool _isAvailable = false;
  int _shipmentCount = 0;
  Uint8List? _cachedProfileImage;

  bool get isAvailable => _isAvailable;
  int get shipmentCount => _shipmentCount;
  Uint8List? get profileImage => _cachedProfileImage;

  DriverHomeCubit(this._driverHomeRepo) : super(const DriverHomeState.initial());

  Future<void> loadAllData(int driverId) async {
    await Future.wait([
      getDriverImage(driverId),
      fetchShipmentCountAndStatus(),
    ]);
    if (kDebugMode) {
      debugPrint('🚀 بدء التشغيل: الحالة النهائية = $_isAvailable');
    }
  }

  
  Future<void> toggleAvailability() async {
    if (isClosed) return;
    final result = await _driverHomeRepo.changeAvailability();
    if (isClosed) return;
    result.when(
      success: (response) {
        _isAvailable = response.availability;
        emit(DriverHomeState.availabilityChanged(
          message: response.message,
          isAvailable: _isAvailable,
        ));
      },
      failure: (error) => emit(DriverHomeState.error(error)),
    );
  }

  Future<void> fetchShipmentCountAndStatus() async {
    if (isClosed) return;
    final response = await _driverHomeRepo.getShipmentCount();
    if (isClosed) return;
    response.when(
      success: (countResponse) {
        _shipmentCount = countResponse.count;
        final backendAvailability = countResponse.availability == 1;

        if (_isAvailable != backendAvailability) {
          _isAvailable = backendAvailability;
          emit(DriverHomeState.availabilityChanged(
            message: "تمت مزامنة الحالة من السيرفر",
            isAvailable: _isAvailable,
          ));
        }
        emit(DriverHomeState.shipmentCountLoaded(_shipmentCount));
      },
      failure: (error) => emit(DriverHomeState.error(error)),
    );
  }


  Future<void> getDriverImage(int driverId) async {
    if (isClosed) return;
    final response = await _driverHomeRepo.getDriverImage(driverId);
    if (isClosed) return;
    response.when(
      success: (bytes) {
        _cachedProfileImage = bytes;
        emit(DriverHomeState.driverImageLoaded(bytes));
      },
      failure: (error) => emit(DriverHomeState.error(error)),
    );
  }


  Future<bool> toggleAvailabilityWithOptimisticUpdate() async {
    await toggleAvailability();
    return _isAvailable;
  }

  Future<void> setOfflineAndClose() async {
    if (!_isAvailable) return;

    final result = await _driverHomeRepo.changeAvailability();
    result.when(
      success: (response) {
        _isAvailable = response.availability;
        emit(DriverHomeState.availabilityChanged(
          message: response.message,
          isAvailable: _isAvailable,
        ));
      },
      failure: (error) {
        _isAvailable = false;
        emit(DriverHomeState.availabilityChanged(
          message: "تم تعيين الحالة محلياً إلى غير متاح",
          isAvailable: false,
        ));
      },
    );
  }


 
}