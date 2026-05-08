import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';

part 'driver_home_state.freezed.dart';

@freezed
class DriverHomeState with _$DriverHomeState {
  const factory DriverHomeState.initial() = _Initial;
  const factory DriverHomeState.loading() = Loading;
  const factory DriverHomeState.availabilityChanged({
    required String message,
    required bool isAvailable,
  }) = AvailabilityChanged;
  const factory DriverHomeState.shipmentCountLoaded(int count) = ShipmentCountLoaded;
  const factory DriverHomeState.driverImageLoaded(Uint8List imageBytes) = DriverImageLoaded;
  const factory DriverHomeState.error(ApiErrorModel apiErrorModel) = Error;
}