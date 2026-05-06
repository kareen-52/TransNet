import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String? message;
  final String? token;
  final String? role;
  @JsonKey(name: "first_login_for_driver")
  final bool? firstLoginForDriver;
  @JsonKey(name: "refresh_token")
  final String? refreshToken;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "driver_id")
  final int? driverId;
  LoginResponse({
    this.message,
    this.token,
    this.role,
    this.firstLoginForDriver,
    this.refreshToken,
    this.userId,
    this.driverId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
