import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';

part 'shipment_details_state.freezed.dart';

/// All possible states of the Shipment Details feature.
///
/// Uses Freezed for exhaustive pattern matching and immutability.
@freezed
class ShipmentDetailsState with _$ShipmentDetailsState {
  /// Initial state before any action is triggered.
  const factory ShipmentDetailsState.initial() = _Initial;

  /// Data is being fetched from the repository.
  const factory ShipmentDetailsState.loading() = _Loading;

  /// Data was fetched successfully.
  const factory ShipmentDetailsState.success(ShipmentDetailsEntity data) =
      _Success;

  /// An error occurred during fetch.
  const factory ShipmentDetailsState.error(ApiErrorModel error) = _Error;
}
