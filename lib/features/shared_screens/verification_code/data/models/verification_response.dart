import 'package:json_annotation/json_annotation.dart';
part 'verification_response.g.dart';

@JsonSerializable()
class VerificationResponse {
  final String? message;
  final String? token;
  @JsonKey(name: "reset_token")
  final String? resetToken;

  @JsonKey(name: "refresh_token")
  final String? refreshToken;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "driver_id")
  final int? driverId;

  VerificationResponse({
    this.message,
    this.token,
    this.resetToken,
    this.refreshToken,
    this.userId,
    this.driverId,
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$VerificationResponseFromJson(json);
}
