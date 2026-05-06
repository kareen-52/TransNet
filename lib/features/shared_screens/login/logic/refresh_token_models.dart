import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_models.g.dart';

@JsonSerializable()
class RefreshTokenRequest {
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}

@JsonSerializable()
class RefreshTokenResponse {
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  RefreshTokenResponse({this.accessToken, this.refreshToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) => 
      _$RefreshTokenResponseFromJson(json);
}