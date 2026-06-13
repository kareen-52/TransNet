import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'shipment_id')
  final int shipmentId;

  @JsonKey(name: 'post_id', defaultValue: 0)
  final int? postId;

  final String title;
  final String message;
  final int status;
  @JsonKey(name: 'created_at')
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.shipmentId,
    this.postId,
    required this.title,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class NotificationListResponse {
  final List<NotificationModel> notifications;
  NotificationListResponse({required this.notifications});
  factory NotificationListResponse.fromJson(Map<String, dynamic> json) => _$NotificationListResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$NotificationListResponseToJson(this);
}