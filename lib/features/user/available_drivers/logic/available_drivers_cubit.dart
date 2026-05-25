import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/home/data/repo/home_driver_repo.dart';
import 'package:graduation_progect/features/user/available_drivers/data/models/driver_model.dart';
import 'package:graduation_progect/features/user/available_drivers/data/models/send_to_driver_request.dart';
import 'package:graduation_progect/features/user/create_shipment/data/repos/create_shipment_repo.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/shipment_model.dart';
import '../data/repos/available_drivers_repo.dart';
import 'available_drivers_state.dart';

class AvailableDriversCubit extends Cubit<AvailableDriversState> {
  final AvailableDriversRepo _driversRepo;
  final CreateShipmentRepo   _shipmentRepo;
  final DriverHomeRepo        _homeRepo;

  Timer? _pollingTimer;
  Timer? _expirationWarningTimer;
  Timer? _actualExpirationTimer;

  ShipmentModel? currentShipment;
  bool isExpirationWarningActive = false;


  final Map<int, Uint8List> _imageCache = {};

  final Set<int> _imageFetching = {};

  AvailableDriversCubit(
    this._driversRepo,
    this._shipmentRepo,
    this._homeRepo,
  ) : super(const AvailableDriversState.loading());

 
  Uint8List? getDriverImageSync(int driverId) => _imageCache[driverId];

  Future<void> prefetchDriverImage(
    int driverId, {
    required void Function(Uint8List bytes) onLoaded,
  }) async {
    if (_imageCache.containsKey(driverId)) {
      onLoaded(_imageCache[driverId]!);
      return;
    }
    if (_imageFetching.contains(driverId)) return;

    _imageFetching.add(driverId);
    try {
      final result = await _homeRepo.getDriverImage(driverId);
      result.when(
        success: (bytes) {
          _imageCache[driverId] = bytes;
          onLoaded(bytes);
        },
        failure: (_) {
          if (kDebugMode) debugPrint('[AvailableDriversCubit] image fetch failed for $driverId');
        },
      );
    } finally {
      _imageFetching.remove(driverId);
    }
  }



  void initEngine() async {
    if (isClosed) return;
    isExpirationWarningActive = false;
    emit(const AvailableDriversState.loading());

    final shipmentResult = await _shipmentRepo.getActiveShipment();
    if (isClosed) return;

    shipmentResult.when(
      success: (shipment) {
        currentShipment = shipment;
        _startExpirationTimer(shipment.expiresAt);
        _fetchDrivers();
        _startPolling();
      },
      failure: (error) => emit(AvailableDriversState.error(error)),
    );
  }

  void _fetchDrivers({bool isSilent = false}) async {
    if (!isSilent && !isClosed) emit(const AvailableDriversState.loading());

    final result = await _driversRepo.getAvailableDrivers();
    if (isClosed) return;

    result.when(
      success: (drivers) {
        if (drivers.isEmpty) {
          emit(const AvailableDriversState.empty());
        } else {
          emit(AvailableDriversState.success(drivers));
        }
      },
      failure: (error) => emit(AvailableDriversState.error(error)),
    );
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      _fetchDrivers(isSilent: true);
    });
  }

  void _startExpirationTimer(String expiresAtStr) {
    _expirationWarningTimer?.cancel();
    _actualExpirationTimer?.cancel();

    final expiresAt = DateTime.parse(expiresAtStr).toLocal();
    final diff = expiresAt.difference(DateTime.now());

    if (diff.inSeconds <= 0) {
      emit(const AvailableDriversState.shipmentExpired());
      return;
    }

    final secondsUntilWarning = diff.inSeconds - 900;
    if (secondsUntilWarning > 0) {
      _expirationWarningTimer = Timer(Duration(seconds: secondsUntilWarning), () {
        isExpirationWarningActive = true;
        emit(const AvailableDriversState.showExtendDialog());
        _actualExpirationTimer = Timer(const Duration(minutes: 15), () {
          emit(const AvailableDriversState.shipmentExpired());
        });
      });
    } else {
      isExpirationWarningActive = true;
      emit(const AvailableDriversState.showExtendDialog());
      _actualExpirationTimer = Timer(diff, () {
        emit(const AvailableDriversState.shipmentExpired());
      });
    }
  }



  void extendShipmentTime() async {
    final result = await _shipmentRepo.extendShipment();
    if (isClosed) return;
    result.when(
      success: (_) {
        isExpirationWarningActive = false;
        emit(const AvailableDriversState.extendSuccess());
        initEngine();
      },
      failure: (error) => emit(AvailableDriversState.error(error)),
    );
  }

  void deleteShipment() async {
    if (isClosed) return;
    emit(const AvailableDriversState.deleteLoading());
    final result = await _shipmentRepo.deleteShipment();
    if (isClosed) return;
    result.when(
      success: (_) => emit(const AvailableDriversState.deleteSuccess()),
      failure: (error) => emit(AvailableDriversState.error(error)),
    );
  }

  void sendToDriver(DriverModel driver) async {
    emit(const AvailableDriversState.sendToDriverLoading());
    final requestBody = SendToDriverRequest(
      driverId:          driver.id,
      price:             driver.price,
      distanceToStart:   driver.distanceToStartKm,
      shipmentDistance:  driver.distanceOfShipment,
    );
    final result = await _driversRepo.sendToDriver(requestBody);
    if (isClosed) return;

    result.when(
      success: (message) {
        if (message.contains('مسبقاً') || message.contains('غير متاح')) {
          emit(AvailableDriversState.actionError(ApiErrorModel(message: message)));
        } else {
          emit(AvailableDriversState.sendToDriverSuccess(message));
        }
      },
      failure: (error) => emit(AvailableDriversState.actionError(error)),
    );
  }



  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    _expirationWarningTimer?.cancel();
    _actualExpirationTimer?.cancel();
    _imageCache.clear();
    _imageFetching.clear();
    return super.close();
  }
}
