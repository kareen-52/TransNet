import 'package:json_annotation/json_annotation.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/party_entity.dart';

part 'party_model.g.dart';

/// Data model for a party (driver or client) involved in a shipment.
/// Responsible only for JSON deserialization.
@JsonSerializable()
class PartyModel {
  final int id;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  @JsonKey(name: 'user_number')
  final String userNumber;

  const PartyModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userNumber,
  });

  factory PartyModel.fromJson(Map<String, dynamic> json) =>
      _$PartyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartyModelToJson(this);

  /// Maps this data model to the corresponding domain entity.
  PartyEntity toEntity() => PartyEntity(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        userNumber: userNumber,
      );
}
