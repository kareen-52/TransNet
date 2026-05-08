import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/models/shipment_details_response.dart';

part 'shipment_details_state.freezed.dart';

@freezed
class ShipmentDetailsState with _$ShipmentDetailsState {
  const factory ShipmentDetailsState.initial() = _Initial;
  const factory ShipmentDetailsState.loading() = Loading;
  const factory ShipmentDetailsState.success(ShipmentDetailsResponse data) = Success;
  const factory ShipmentDetailsState.error(ApiErrorModel error) = Error;

}