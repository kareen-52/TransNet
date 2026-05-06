import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import '../data/models/driver_model.dart';

part 'available_drivers_state.freezed.dart';

@freezed
class AvailableDriversState with _$AvailableDriversState {
  const factory AvailableDriversState.loading() = Loading;
  const factory AvailableDriversState.success(List<DriverModel> drivers) = Success;
  const factory AvailableDriversState.empty() = Empty;
  const factory AvailableDriversState.error(ApiErrorModel error) = Error;

  const factory AvailableDriversState.showExtendDialog() = ShowExtendDialog;
  const factory AvailableDriversState.extendSuccess() = ExtendSuccess;
  const factory AvailableDriversState.shipmentExpired() = ShipmentExpired;

  const factory AvailableDriversState.deleteLoading() = DeleteLoading;
  const factory AvailableDriversState.deleteSuccess() = DeleteSuccess;


  const factory AvailableDriversState.sendToDriverLoading() = SendToDriverLoading;
  const factory AvailableDriversState.sendToDriverSuccess(String message) = SendToDriverSuccess;
  
  const factory AvailableDriversState.actionError(ApiErrorModel error) = ActionError;
}