// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyModel _$PartyModelFromJson(Map<String, dynamic> json) => PartyModel(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  phoneNumber: json['phone_number'] as String,
  userNumber: json['user_number'] as String,
);

Map<String, dynamic> _$PartyModelToJson(PartyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'user_number': instance.userNumber,
    };
