import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import '../data/models/governorate_model.dart';
part 'create_shipment_state.freezed.dart';

@freezed
class CreateShipmentState with _$CreateShipmentState {
  const factory CreateShipmentState.initial() = _Initial;
  
  const factory CreateShipmentState.govLoading() = GovLoading;
  const factory CreateShipmentState.govSuccess(List<GovernorateModel> governorates) = GovSuccess;
  const factory CreateShipmentState.govError(ApiErrorModel error) = GovError;

  const factory CreateShipmentState.submitLoading() = SubmitLoading;
  const factory CreateShipmentState.submitSuccess(String message) = SubmitSuccess;
  const factory CreateShipmentState.submitError(ApiErrorModel error) = SubmitError;

  const factory CreateShipmentState.uiUpdated(int timeStamp) = UiUpdated;
}