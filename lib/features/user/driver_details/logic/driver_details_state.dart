import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import '../data/models/driver_details_model.dart';
part 'driver_details_state.freezed.dart';

@freezed
class DriverDetailsState with _$DriverDetailsState {
  const factory DriverDetailsState.loading() = Loading;
  const factory DriverDetailsState.success(DriverDetailsModel details) = Success;
  const factory DriverDetailsState.error(ApiErrorModel error) = Error;
}