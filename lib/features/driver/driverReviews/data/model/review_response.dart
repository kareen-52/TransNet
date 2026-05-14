import 'package:json_annotation/json_annotation.dart';

part 'review_response.g.dart';

@JsonSerializable()
class ReviewResponse {
  final ReviewData? data;

  ReviewResponse({this.data});

  factory ReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseFromJson(json);
}

@JsonSerializable()
class ReviewData {
  @JsonKey(name: 'average_rate')
  final double? averageRate;
  @JsonKey(name: 'reviews_count')
  final int? reviewsCount;
  final List<Review>? reviews;

  ReviewData({this.averageRate, this.reviewsCount, this.reviews});

  factory ReviewData.fromJson(Map<String, dynamic> json) =>
      _$ReviewDataFromJson(json);
}

@JsonSerializable()
class Review {
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'driver_id')
  final int? driverId;
  final String? rate;
  final String? review;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final UserInfo? user;

  Review({
    this.id,
    this.userId,
    this.driverId,
    this.rate,
    this.review,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);
}

@JsonSerializable()
class UserInfo {
  final int? id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'user_number')
  final String? userNumber;

  UserInfo({this.id, this.firstName, this.lastName, this.userNumber});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}