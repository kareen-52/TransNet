

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
part 'driver_shipments_state.freezed.dart';
@freezed
class DriverShipmentsState with _$DriverShipmentsState {
  const factory DriverShipmentsState.initial() = _Initial;
  const factory DriverShipmentsState.loading() = Loading;
  const factory DriverShipmentsState.success(List<ShipmentModel> shipments, bool hasReachedMax) = Success;
  const factory DriverShipmentsState.error(ApiErrorModel apiErrorModel) = Error;
}