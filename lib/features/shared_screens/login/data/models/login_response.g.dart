// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      message: json['message'] as String?,
      token: json['token'] as String?,
      role: json['role'] as String?,
      firstLoginForDriver: json['first_login_for_driver'] as bool?,
      refreshToken: json['refresh_token'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      driverId: (json['driver_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'role': instance.role,
      'first_login_for_driver': instance.firstLoginForDriver,
      'refresh_token': instance.refreshToken,
      'user_id': instance.userId,
      'driver_id': instance.driverId,
    };
