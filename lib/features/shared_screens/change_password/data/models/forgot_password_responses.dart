import 'package:json_annotation/json_annotation.dart';
part 'forgot_password_responses.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  final String? message;
  @JsonKey(name: 'reset_token')
  final String? resetToken;

  ForgotPasswordResponse({this.message, this.resetToken});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}