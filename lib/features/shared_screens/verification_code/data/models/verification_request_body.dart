import 'package:json_annotation/json_annotation.dart';
part 'verification_request_body.g.dart';

@JsonSerializable()
class VerificationRequestBody {
  final String email;
  @JsonKey(name: 'verification_code')
  final String verificationCode;

  VerificationRequestBody({
    required this.email,
    required this.verificationCode,
  });

  Map<String, dynamic> toJson() => _$VerificationRequestBodyToJson(this);
}