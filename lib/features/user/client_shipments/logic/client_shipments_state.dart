import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';

part 'client_shipments_state.freezed.dart';

@freezed
class ClientShipmentsState with _$ClientShipmentsState {
  const factory ClientShipmentsState.initial()                                          = _Initial;
  const factory ClientShipmentsState.loading()                                          = Loading;
  const factory ClientShipmentsState.success(List<ShipmentModel> shipments, bool hasReachedMax) = Success;
  const factory ClientShipmentsState.empty()                                            = Empty;
  const factory ClientShipmentsState.error(ApiErrorModel apiErrorModel)                = Error;
}
