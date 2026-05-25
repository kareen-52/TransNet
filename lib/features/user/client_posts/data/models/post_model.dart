import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';


String? _stringFromJson(dynamic value) => value?.toString();

@JsonSerializable()
class PostModel {
  final int id;

  @JsonKey(name: 'user_id')
  final int userId;


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

  PostModel({
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

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
