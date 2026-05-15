import 'package:freezed_annotation/freezed_annotation.dart';
part 'driver_tracking_state.freezed.dart';

@freezed
class DriverTrackingState with _$DriverTrackingState {
  const factory DriverTrackingState.initial() = _Initial;
  
  const factory DriverTrackingState.loadingQr() = _LoadingQr;
  const factory DriverTrackingState.successQr(String message) = _SuccessQr;
  const factory DriverTrackingState.errorQr(String error) = _ErrorQr;

  const factory DriverTrackingState.loadingPin() = _LoadingPin;
  const factory DriverTrackingState.successPin(String message) = _SuccessPin;
  const factory DriverTrackingState.errorPin(String error) = _ErrorPin;
}