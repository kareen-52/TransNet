import 'package:json_annotation/json_annotation.dart';

part 'client_post_model.g.dart';

// ✅ دالة مساعدة سحرية لتحويل أي رقم (int أو double) إلى String بأمان تام
String? _stringFromJson(dynamic value) => value?.toString();

@JsonSerializable()
class ClientPostModel {
  final int id;
  
  @JsonKey(name: 'user_id')
  final int userId;
  
  // حمينا هذه الحقول أيضاً تحسباً لأي تغيير من الباك إند
  @JsonKey(fromJson: _stringFromJson)
  final String? weight;
  
  @JsonKey(fromJson: _stringFromJson)
  final String? height;
  
  @JsonKey(fromJson: _stringFromJson)
  final String? width;
  
  @JsonKey(fromJson: _stringFromJson)
  final String? length;
  
  final String? object;
  final int? insurance;

  // ✅ استخدام الدالة المساعدة لحماية التطبيق من أخطاء الـ double والـ String
  @JsonKey(name: 'start_position_lat', fromJson: _stringFromJson)
  final String? startPositionLat;
  
  @JsonKey(name: 'start_position_lng', fromJson: _stringFromJson)
  final String? startPositionLng;
  
  @JsonKey(name: 'end_position_lat', fromJson: _stringFromJson)
  final String? endPositionLat;
  
  @JsonKey(name: 'end_position_lng', fromJson: _stringFromJson)
  final String? endPositionLng;
  
  @JsonKey(name: 'start_location_details')
  final String? startLocationDetails;
  
  @JsonKey(name: 'end_location_details')
  final String? endLocationDetails;
  
  @JsonKey(name: 'max_price')
  final num? maxPrice;
  
  @JsonKey(name: 'min_price')
  final num? minPrice;
  
  @JsonKey(name: 'last_date')
  final String? lastDate;
  
  final int? finished;
  
  @JsonKey(name: 'start_governorate')
  final String? startGovernorate;
  
  @JsonKey(name: 'end_governorate')
  final String? endGovernorate;
  
  @JsonKey(name: 'created_at')
  final String? createdAt;

  ClientPostModel({
    required this.id,
    required this.userId,
    this.weight,
    this.height,
    this.width,
    this.length,
    this.object,
    this.insurance,
    this.startPositionLat,
    this.startPositionLng,
    this.endPositionLat,
    this.endPositionLng,
    this.startLocationDetails,
    this.endLocationDetails,
    this.maxPrice,
    this.minPrice,
    this.lastDate,
    this.finished,
    this.startGovernorate,
    this.endGovernorate,
    this.createdAt,
  });

  factory ClientPostModel.fromJson(Map<String, dynamic> json) =>
      _$ClientPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientPostModelToJson(this);
}