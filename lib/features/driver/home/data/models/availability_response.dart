import 'package:json_annotation/json_annotation.dart';

part 'availability_response.g.dart';

@JsonSerializable()
class AvailabilityResponse {
  final String message;
  final bool availability;


  AvailabilityResponse({required this.message, required this.availability});

  factory AvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityResponseFromJson(json);
}
