import 'package:json_annotation/json_annotation.dart';
part 'driver_shipments_response.g.dart';

@JsonSerializable()
class DriverShipmentsResponse {
  final List<ShipmentModel>? data;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'last_page')
  final int? lastPage;
  final int? total;
  @JsonKey(name: 'per_page')
  final int? perPage;
  @JsonKey(name: 'next_page_url')
  final String? nextPageUrl;
  @JsonKey(name: 'prev_page_url')
  final String? prevPageUrl;
  @JsonKey(name: 'first_page_url')
  final String? firstPageUrl;
  @JsonKey(name: 'last_page_url')
  final String? lastPageUrl;

  DriverShipmentsResponse({
    this.data,
    this.currentPage,
    this.lastPage,
    this.total,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
    this.firstPageUrl,
    this.lastPageUrl,
  });

  factory DriverShipmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverShipmentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverShipmentsResponseToJson(this);
}

@JsonSerializable()
class ShipmentModel {
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'driver_id')
  final int? driverId;
  @JsonKey(name: 'shipment_number')
  final int? shipmentNumber;
  final String? width, height, length, weight;
  final String? object;
  final int? insurance;
  final int? price;
  final String? status;
  final int? success;
  @JsonKey(name: 'start_governorate')
  final String? startGovernorate;
  @JsonKey(name: 'end_governorate')
  final String? endGovernorate;
  bool get isCompleted => success == 1 || status == 'مستلمة';
  ShipmentModel({
    this.id,
    this.shipmentNumber,
    this.width,
    this.height,
    this.length,
    this.weight,
    this.object,
    this.insurance,
    this.price,
    this.status,
    this.success,
    this.startGovernorate,
    this.endGovernorate,
    this.userId,
    this.driverId,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) =>
      _$ShipmentModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentModelToJson(this);
}
