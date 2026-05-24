import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/home/data/repo/home_driver_repo.dart';
import 'package:graduation_progect/hive_cache_service.dart';
import 'driver_home_state.dart';

/// DriverHomeCubit — must be registered as Factory (NOT singleton).
///
/// Profile image policy — PERSISTENT CACHE + ONLINE VALIDATION:
///  • On launch: serve cached bytes instantly (survives app restart via Hive).
///  • When online: compare imageUrl from profile; download only if changed.
///  • When offline: cached bytes are served silently.
///
/// Available-driver images are NOT managed here — they live in
/// AvailableDriversCubit as session-memory only.
class DriverHomeCubit extends Cubit<DriverHomeState> {
  final DriverHomeRepo _homeRepo;

  bool       _isAvailable   = false;
  int        _shipmentCount = 0;
  Uint8List? _profileImageBytes; // fast in-memory ref for this session

  bool       get isAvailable   => _isAvailable;
  int        get shipmentCount => _shipmentCount;
  Uint8List? get profileImage  => _profileImageBytes;

  DriverHomeCubit(this._homeRepo) : super(const DriverHomeState.initial());

  // ── Startup ────────────────────────────────────────────────────────────────

  /// Call once after login with the driver's id and current imageUrl from profile.
  Future<void> loadAllData(int driverId, {String? currentImageUrl}) async {
    // 1. Emit cached image immediately (no loading flash for returning users)
    final cached = HiveCacheService.getCachedDriverImage(driverId);
    if (cached != null) {
      _profileImageBytes = cached;
      if (!isClosed) emit(DriverHomeState.driverImageLoaded(cached));
    }

    // 2. Run in parallel: validate/refresh image + shipment count
    await Future.wait([
      _refreshImage(driverId, currentImageUrl: currentImageUrl),
      fetchShipmentCountAndStatus(),
    ]);

    if (kDebugMode) debugPrint('🚀 DriverHomeCubit.loadAllData complete');
  }

  // ── Image ──────────────────────────────────────────────────────────────────

  Future<void> _refreshImage(int driverId, {String? currentImageUrl}) async {
    if (isClosed) return;

    final result = await _homeRepo.getOrRefreshDriverImage(
      driverId,
      currentImageUrl: currentImageUrl,
    );
    if (isClosed) return;

    result.when(
      success: (bytes) {
        // Only re-emit if image actually changed (avoids unnecessary rebuilds)
        if (bytes.length != (_profileImageBytes?.length ?? 0)) {
          _profileImageBytes = bytes;
          emit(DriverHomeState.driverImageLoaded(bytes));
        }
      },
      failure: (_) {
        // Cached image already emitted above — nothing more to do
      },
    );
  }

  /// Force re-download (e.g. after profile edit changed image on server).
  Future<void> refreshDriverImage(int driverId, {String? newImageUrl}) =>
      _refreshImage(driverId, currentImageUrl: newImageUrl);

  // ── Availability ───────────────────────────────────────────────────────────

  Future<void> toggleAvailability() async {
    if (isClosed) return;
    final result = await _homeRepo.changeAvailability();
    if (isClosed) return;
    result.when(
      success: (response) {
        _isAvailable = response.availability;
        emit(DriverHomeState.availabilityChanged(
          message:     response.message,
          isAvailable: _isAvailable,
        ));
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

  // ── Shipment count ─────────────────────────────────────────────────────────

  Future<void> fetchShipmentCountAndStatus() async {
    if (isClosed) return;
    final response = await _homeRepo.getShipmentCount();
    if (isClosed) return;

    response.when(
      success: (countResponse) {
        _shipmentCount = countResponse.count;
        final backendAvailable = countResponse.availability == 1;
        if (_isAvailable != backendAvailable) {
          _isAvailable = backendAvailable;
          emit(DriverHomeState.availabilityChanged(
            message:     'تمت مزامنة الحالة من السيرفر',
            isAvailable: _isAvailable,
          ));
        }
        emit(DriverHomeState.shipmentCountLoaded(_shipmentCount));
      },
      failure: (error) => emit(DriverHomeState.error(error)),
    );
  }

  // ── Reset (called by CacheAwareLogout) ─────────────────────────────────────

  void reset() {
    _profileImageBytes = null;
    _isAvailable       = false;
    _shipmentCount     = 0;
    if (!isClosed) emit(const DriverHomeState.initial());
  }
}
