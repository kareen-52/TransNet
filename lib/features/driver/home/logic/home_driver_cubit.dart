import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/home/data/repo/home_driver_repo.dart';
import 'package:graduation_progect/hive_cache_service.dart';
import 'driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  final DriverHomeRepo _homeRepo;

  bool _isAvailable = false;
  double _financialPrize = 0.0;
  int _shipmentCount = 0;
  Uint8List? _profileImageBytes;

  bool get isAvailable => _isAvailable;
  int get shipmentCount => _shipmentCount;
  Uint8List? get profileImage => _profileImageBytes;
  double get financialPrize => _financialPrize;

  DriverHomeCubit(this._homeRepo) : super(const DriverHomeState.initial());

  Future<void> loadAllData(int driverId, {String? currentImageUrl}) async {
    final cached = HiveCacheService.getCachedDriverImage(driverId);
    if (cached != null) {
      _profileImageBytes = cached;
      if (!isClosed) emit(DriverHomeState.driverImageLoaded(cached));
    }

    await Future.wait([
      _refreshImage(driverId, currentImageUrl: currentImageUrl),
      fetchShipmentCountAndStatus(),
    ]);

    if (kDebugMode) debugPrint('🚀 DriverHomeCubit.loadAllData complete');
  }

  Future<void> _refreshImage(int driverId, {String? currentImageUrl}) async {
    if (isClosed) return;

    final result = await _homeRepo.getOrRefreshDriverImage(
      driverId,
      currentImageUrl: currentImageUrl,
    );
    if (isClosed) return;

    result.when(
      success: (bytes) {
        if (bytes.length != (_profileImageBytes?.length ?? 0)) {
          _profileImageBytes = bytes;
          emit(DriverHomeState.driverImageLoaded(bytes));
        }
      },
      failure: (_) {},
    );
  }

  Future<void> refreshDriverImage(int driverId, {String? newImageUrl}) =>
      _refreshImage(driverId, currentImageUrl: newImageUrl);

  Future<void> toggleAvailability() async {
    if (isClosed) return;
    final result = await _homeRepo.changeAvailability();
    if (isClosed) return;
    result.when(
      success: (response) {
        _isAvailable = response.availability;
        emit(
          DriverHomeState.availabilityChanged(
            message: response.message,
            isAvailable: _isAvailable,
          ),
        );
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
    await _homeRepo.changeAvailability();
  }

  Future<void> fetchShipmentCountAndStatus() async {
    if (isClosed) return;
    final response = await _homeRepo.getShipmentCount();
    if (isClosed) return;

    response.when(
      success: (countResponse) {
        _shipmentCount = countResponse.count;
        

        _financialPrize = double.tryParse(countResponse.reward.toString()) ?? 0.0;
        
        final backendAvailable = countResponse.availability == 1;
        if (_isAvailable != backendAvailable) {
          _isAvailable = backendAvailable;
          emit(
            DriverHomeState.availabilityChanged(
              message: 'تمت مزامنة الحالة من السيرفر',
              isAvailable: _isAvailable,
            ),
          );
        }
        // التعديل هنا: تمرير القيمة للـ State 👇
        emit(DriverHomeState.shipmentCountLoaded(_shipmentCount, _financialPrize));
      },
      failure: (error) => emit(DriverHomeState.error(error)),
    );
  }

  void reset() {
    _profileImageBytes = null;
    _isAvailable = false;
    _shipmentCount = 0;
    if (!isClosed) emit(const DriverHomeState.initial());
  }
}
