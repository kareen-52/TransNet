// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailabilityResponse _$AvailabilityResponseFromJson(
  Map<String, dynamic> json,
) => AvailabilityResponse(
  message: json['message'] as String,
  availability: json['availability'] as bool,
);

Map<String, dynamic> _$AvailabilityResponseToJson(
  AvailabilityResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'availability': instance.availability,
};
