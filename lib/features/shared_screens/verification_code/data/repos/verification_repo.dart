import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/data/models/verification_request_body.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/data/models/verification_response.dart';

class VerificationRepo {
  final ApiService _apiService;

  VerificationRepo(this._apiService);

  
  Future<ApiResult<VerificationResponse>> verifyEmail(
      VerificationRequestBody verificationRequestBody) async {
    try {
      final response = await _apiService.emailVerification(verificationRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}