import 'package:json_annotation/json_annotation.dart';
part 'forgot_password_request_bodies.g.dart';

@JsonSerializable()
class SendEmailRequestBody {
  final String email;
  SendEmailRequestBody({required this.email});
  Map<String, dynamic> toJson() => _$SendEmailRequestBodyToJson(this);
}

@JsonSerializable()
class VerifyPasswordRequestBody {
  final String email;
  @JsonKey(name: 'verification_code')
  final String verificationCode;
  VerifyPasswordRequestBody({required this.email, required this.verificationCode});
  Map<String, dynamic> toJson() => _$VerifyPasswordRequestBodyToJson(this);
}

@JsonSerializable()
class ResetPasswordRequestBody {
  final String email;
  @JsonKey(name: 'reset_token')
  final String resetToken;
  @JsonKey(name: 'new_password')
  final String newPassword;
  ResetPasswordRequestBody({required this.email, required this.resetToken, required this.newPassword});
  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyToJson(this);
}