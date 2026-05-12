import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_order_model.freezed.dart';
part 'active_order_model.g.dart';

@freezed
abstract class ActiveOrderModel with _$ActiveOrderModel {
  const factory ActiveOrderModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'driver_id') required int driverId,
    @JsonKey(name: 'shipment_number') required int shipmentNumber,
    required double price,
    required String status,
    required ActiveOrderDriverModel driver,
  }) = _ActiveOrderModel;

  factory ActiveOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveOrderModelFromJson(json);
}

@freezed
abstract class ActiveOrderDriverModel with _$ActiveOrderDriverModel {
  const factory ActiveOrderDriverModel({
    required int id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    @JsonKey(name: 'user_number') required String userNumber,
  }) = _ActiveOrderDriverModel;

  factory ActiveOrderDriverModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveOrderDriverModelFromJson(json);
}
