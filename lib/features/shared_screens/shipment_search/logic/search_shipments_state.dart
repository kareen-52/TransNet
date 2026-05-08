import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
part 'search_shipments_state.freezed.dart';

@freezed
class SearchShipmentsState with _$SearchShipmentsState {
  const factory SearchShipmentsState.initial() = _Initial;
  const factory SearchShipmentsState.loading() = _Loading;
  const factory SearchShipmentsState.loaded(List<ShipmentModel> shipments) = _Loaded;
  const factory SearchShipmentsState.empty() = _Empty;
  const factory SearchShipmentsState.error(ApiErrorModel error) = _Error;
}