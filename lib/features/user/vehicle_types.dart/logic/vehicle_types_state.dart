import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import '../data/models/vehicle_type_model.dart';
part 'vehicle_types_state.freezed.dart';

@freezed
class VehicleTypesState with _$VehicleTypesState {
  const factory VehicleTypesState.initial() = _Initial;
  const factory VehicleTypesState.loading() = Loading;
  const factory VehicleTypesState.success(List<VehicleTypeModel> vehicles) = Success;
  const factory VehicleTypesState.error(ApiErrorModel error) = Error;
}