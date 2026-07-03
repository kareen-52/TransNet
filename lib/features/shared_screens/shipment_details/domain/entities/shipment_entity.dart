class ShipmentEntity {
  final int id;
  final int userId;
  final int? driverId;
  final int shipmentNumber;
  final String? pin;
  final String? qrPin;
  final String createdAt;
  final String updatedAt;
  final String? weight;
  final String? height;
  final String? width;
  final String? length;
  final String? object;
  // final int? insurance;
  final String startPositionLat;
  final String startPositionLng;
  final String endPositionLat;
  final String endPositionLng;
  final String startGovernorate;
  final String endGovernorate;
  final int? price;
  final String? status;
  final int? success;
  final String? deliveryDeadline;

  const ShipmentEntity({
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
    // this.insurance,
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

  bool get isCompleted => success == 1 || status == 'مستلمة';


  bool get hasPin => pin != null && pin!.isNotEmpty;
  bool get hasQrPin => qrPin != null && qrPin!.isNotEmpty;
  bool get hasDimensions => width != null || height != null || length != null;

  // bool get hasInsurance => insurance == 1;

  String get displayStatus =>
      status ?? (isCompleted ? 'مكتملة' : 'قيد التنفيذ');
}
