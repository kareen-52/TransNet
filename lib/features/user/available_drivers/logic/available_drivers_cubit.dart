import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/user/available_drivers/data/models/driver_model.dart';
import 'package:graduation_progect/features/user/available_drivers/data/models/send_to_driver_request.dart';
import 'package:graduation_progect/features/user/create_shipment/data/repos/create_shipment_repo.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/shipment_model.dart';
import '../data/repos/available_drivers_repo.dart';
import 'available_drivers_state.dart';

class AvailableDriversCubit extends Cubit<AvailableDriversState> {
  final AvailableDriversRepo _driversRepo;
  final CreateShipmentRepo _shipmentRepo;

  Timer? _pollingTimer;
  Timer? _expirationWarningTimer;
  Timer? _actualExpirationTimer;

  ShipmentModel? currentShipment;
  bool isExpirationWarningActive = false;

  AvailableDriversCubit(this._driversRepo, this._shipmentRepo)
    : super(const AvailableDriversState.loading());

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
      failure: (error) {
        emit(AvailableDriversState.error(error));
      },
    );
  }

  void _fetchDrivers({bool isSilent = false}) async {
    if (!isSilent) {
      if (isClosed) return;
      emit(const AvailableDriversState.loading());
    }

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

    DateTime expiresAt = DateTime.parse(expiresAtStr).toLocal();
    DateTime now = DateTime.now();
    Duration difference = expiresAt.difference(now);

    if (difference.inSeconds <= 0) {
      emit(const AvailableDriversState.shipmentExpired());
      return;
    }

    int secondsUntilWarning = difference.inSeconds - 900;

    if (secondsUntilWarning > 0) {
      _expirationWarningTimer = Timer(
        Duration(seconds: secondsUntilWarning),
        () {
          isExpirationWarningActive = true;
          emit(const AvailableDriversState.showExtendDialog());

          _actualExpirationTimer = Timer(const Duration(minutes: 15), () {
            emit(const AvailableDriversState.shipmentExpired());
          });
        },
      );
    } else {
      isExpirationWarningActive = true;
      emit(const AvailableDriversState.showExtendDialog());

      _actualExpirationTimer = Timer(difference, () {
        emit(const AvailableDriversState.shipmentExpired());
      });
    }
  }

  void extendShipmentTime() async {
    final result = await _shipmentRepo.extendShipment();
    if (isClosed) return;

    result.when(
      success: (data) {
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
      driverId: driver.id,
      price: driver.price,
      distanceToStart: driver.distanceToStartKm,
      shipmentDistance: driver.distanceOfShipment,
    );

    final result = await _driversRepo.sendToDriver(requestBody);
    if (isClosed) return;

    // result.when(
    //   success: (message) => emit(AvailableDriversState.sendToDriverSuccess(message)),
    //   failure: (error) => emit(AvailableDriversState.actionError(error)),
    // );
    result.when(
      success: (message) {
        if (message.contains('مسبقاً') || message.contains('غير متاح')) {
          emit(
            AvailableDriversState.actionError(ApiErrorModel(message: message)),
          );
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
    return super.close();
  }
}
