import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable(includeIfNull: false)
class EditProfileRequest {
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  EditProfileRequest({
    this.firstName,
    this.lastName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);
}