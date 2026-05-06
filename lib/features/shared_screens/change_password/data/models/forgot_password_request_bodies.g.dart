// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_request_bodies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendEmailRequestBody _$SendEmailRequestBodyFromJson(
  Map<String, dynamic> json,
) => SendEmailRequestBody(email: json['email'] as String);

Map<String, dynamic> _$SendEmailRequestBodyToJson(
  SendEmailRequestBody instance,
) => <String, dynamic>{'email': instance.email};

VerifyPasswordRequestBody _$VerifyPasswordRequestBodyFromJson(
  Map<String, dynamic> json,
) => VerifyPasswordRequestBody(
  email: json['email'] as String,
  verificationCode: json['verification_code'] as String,
);

Map<String, dynamic> _$VerifyPasswordRequestBodyToJson(
  VerifyPasswordRequestBody instance,
) => <String, dynamic>{
  'email': instance.email,
  'verification_code': instance.verificationCode,
};

ResetPasswordRequestBody _$ResetPasswordRequestBodyFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequestBody(
  email: json['email'] as String,
  resetToken: json['reset_token'] as String,
  newPassword: json['new_password'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestBodyToJson(
  ResetPasswordRequestBody instance,
) => <String, dynamic>{
  'email': instance.email,
  'reset_token': instance.resetToken,
  'new_password': instance.newPassword,
};
