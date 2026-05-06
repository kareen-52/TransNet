// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordResponse(
  message: json['message'] as String?,
  resetToken: json['reset_token'] as String?,
);

Map<String, dynamic> _$ForgotPasswordResponseToJson(
  ForgotPasswordResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'reset_token': instance.resetToken,
};
