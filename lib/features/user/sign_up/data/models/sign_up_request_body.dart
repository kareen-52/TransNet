import 'package:json_annotation/json_annotation.dart';
part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {


  final String email;
  final String password;
@JsonKey(name: 'first_name')
  final String firstName;
@JsonKey(name: 'last_name')
  final String lastName;


@JsonKey(name: 'phone_number')
  final String phoneNumber;

  SignupRequestBody({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
   
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
}