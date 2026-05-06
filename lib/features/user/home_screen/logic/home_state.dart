import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/shipment_model.dart';
part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.hasActiveShipment(ShipmentModel shipment) = HasActiveShipment;
  const factory HomeState.noActiveShipment() = NoActiveShipment;
  const factory HomeState.error(ApiErrorModel error) = Error;
}