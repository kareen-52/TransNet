import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';

part 'shipment_details_state.freezed.dart';

@freezed
class ShipmentDetailsState with _$ShipmentDetailsState {

  const factory ShipmentDetailsState.initial() = _Initial;

  const factory ShipmentDetailsState.loading() = _Loading;


  const factory ShipmentDetailsState.success(ShipmentDetailsEntity data) =
      _Success;

  const factory ShipmentDetailsState.error(ApiErrorModel error) = _Error;
}
