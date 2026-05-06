import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'shipment_id')
  final int shipmentId;
  final String title;
  final String message;
  final int status; // 0 = غير مقروء, 1 = مقروء
  @JsonKey(name: 'created_at')
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.shipmentId,
    required this.title,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
}

@JsonSerializable()
class NotificationListResponse {
  final List<NotificationModel> notifications;
  NotificationListResponse({required this.notifications});
  factory NotificationListResponse.fromJson(Map<String, dynamic> json) => _$NotificationListResponseFromJson(json);
}