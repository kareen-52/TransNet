// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationResponse _$VerificationResponseFromJson(
  Map<String, dynamic> json,
) => VerificationResponse(
  message: json['message'] as String?,
  token: json['token'] as String?,
  resetToken: json['reset_token'] as String?,
  refreshToken: json['refresh_token'] as String?,
  userId: (json['user_id'] as num?)?.toInt(),
  driverId: (json['driver_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$VerificationResponseToJson(
  VerificationResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'token': instance.token,
  'reset_token': instance.resetToken,
  'refresh_token': instance.refreshToken,
  'user_id': instance.userId,
  'driver_id': instance.driverId,
};
