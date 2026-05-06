import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? message;
  final Map<String, dynamic>? errors;
  final int? code;
  final String? type;

  ApiErrorModel({
    this.message,
    this.errors,
    this.code,
    this.type,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String getAllErrorMessages() {
    if (message != null && message!.isNotEmpty) return message!;
    if (errors != null && errors!.isNotEmpty) {
      final errorMessages = errors!.entries.map((entry) {
        if (entry.value is List) return (entry.value as List).join(', ');
        return entry.value.toString();
      }).toList();
      return errorMessages.join('\n');
    }
    return 'حدث خطأ غير معروف';
  }
}