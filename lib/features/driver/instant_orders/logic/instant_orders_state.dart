import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/driver/instant_orders/data/models/instant_order_model.dart';

part 'instant_orders_state.freezed.dart';

@freezed
class InstantOrdersState with _$InstantOrdersState {
  const factory InstantOrdersState.initial() = _Initial;
  const factory InstantOrdersState.loading() = Loading;
  const factory InstantOrdersState.success(List<InstantOrderModel> orders) = Success;
  const factory InstantOrdersState.empty() = Empty;
  const factory InstantOrdersState.error(ApiErrorModel apiErrorModel) = Error;
}