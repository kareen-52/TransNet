import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
part 'driver_location_state.freezed.dart';

@freezed
class DriverLocationState with _$DriverLocationState {
  const factory DriverLocationState.initial() = _Initial;
  const factory DriverLocationState.loading() = Loading;
  const factory DriverLocationState.success(String message) = Success;
  const factory DriverLocationState.error(ApiErrorModel apiErrorModel) = Error;
}