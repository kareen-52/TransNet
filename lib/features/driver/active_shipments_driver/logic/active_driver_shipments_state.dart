import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import '../data/models/active_driver_shipment_model.dart';

part 'active_driver_shipments_state.freezed.dart';

@freezed
class ActiveDriverShipmentsState with _$ActiveDriverShipmentsState {

  const factory ActiveDriverShipmentsState.initial() = _Initial;


  const factory ActiveDriverShipmentsState.loading() = _Loading;

  const factory ActiveDriverShipmentsState.empty() = _Empty;

  
  const factory ActiveDriverShipmentsState.loaded(
    List<ActiveDriverShipmentModel> shipments,
  ) = _Loaded;


  const factory ActiveDriverShipmentsState.error(ApiErrorModel error) = _Error;
}
