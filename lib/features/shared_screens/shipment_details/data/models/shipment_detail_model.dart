import 'package:json_annotation/json_annotation.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_entity.dart';

part 'shipment_detail_model.g.dart';


@JsonSerializable()
class ShipmentDetailModel {
  final int id;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'driver_id')
  final int? driverId;

  @JsonKey(name: 'shipment_number')
  final int shipmentNumber;

  @JsonKey(name: 'pin')
  final String? pin;

  @JsonKey(name: 'qr_pin')
  final String? qrPin;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  final String? weight;
  final String? height;
  final String? width;
  final String? length;
  final String? object;

  @JsonKey(name: 'start_position_lat')
  final String startPositionLat;

  @JsonKey(name: 'start_position_lng')
  final String startPositionLng;

  @JsonKey(name: 'end_position_lat')
  final String endPositionLat;

  @JsonKey(name: 'end_position_lng')
  final String endPositionLng;

  @JsonKey(name: 'start_governorate')
  final String startGovernorate;

  @JsonKey(name: 'end_governorate')
  final String endGovernorate;

  final int? price;
  final String? status;
  final int? success;

  @JsonKey(name: 'delivery_deadline')
  final String? deliveryDeadline;


  const ShipmentDetailModel({
    required this.id,
    required this.userId,
    this.driverId,
    required this.shipmentNumber,
    this.pin,
    this.qrPin,
    required this.createdAt,
    required this.updatedAt,
    this.weight,
    this.height,
    this.width,
    this.length,
    this.object,
    required this.startPositionLat,
    required this.startPositionLng,
    required this.endPositionLat,
    required this.endPositionLng,
    required this.startGovernorate,
    required this.endGovernorate,
    this.price,
    this.status,
    this.success,
    this.deliveryDeadline,

  });

  factory ShipmentDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ShipmentDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShipmentDetailModelToJson(this);


  ShipmentEntity toEntity() => ShipmentEntity(
        id: id,
        userId: userId,
        driverId: driverId,
        shipmentNumber: shipmentNumber,
        pin: pin,
        qrPin: qrPin,
        createdAt: createdAt,
        updatedAt: updatedAt,
        weight: weight,
        height: height,
        width: width,
        length: length,
        object: object,
        startPositionLat: startPositionLat,
        startPositionLng: startPositionLng,
        endPositionLat: endPositionLat,
        endPositionLng: endPositionLng,
        startGovernorate: startGovernorate,
        endGovernorate: endGovernorate,
        price: price,
        status: status,
        success: success,
        deliveryDeadline: deliveryDeadline,
   
      );
}
