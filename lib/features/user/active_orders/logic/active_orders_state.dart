import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import '../data/models/active_order_model.dart';

part 'active_orders_state.freezed.dart';


@freezed
abstract class ActiveOrdersState with _$ActiveOrdersState {
  const factory ActiveOrdersState.initial() = _Initial;

  const factory ActiveOrdersState.loading() = _Loading;

  const factory ActiveOrdersState.empty() = _Empty;

  const factory ActiveOrdersState.loaded(
    List<ActiveOrderModel> orders,
  ) = _Loaded;

  const factory ActiveOrdersState.error(ApiErrorModel error) = _Error;
}
