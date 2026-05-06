import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/shared_screens/change_password/data/models/forgot_password_request_bodies.dart';
import 'package:graduation_progect/features/shared_screens/change_password/data/models/forgot_password_responses.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/data/models/verification_request_body.dart';
class ForgotPasswordRepo {
  final ApiService _apiService;
  ForgotPasswordRepo(this._apiService);


  Future<ApiResult<ForgotPasswordResponse>> sendEmail(String email) async {
    try {
      final response = await _apiService.sendEmailForgetPassword(
        SendEmailRequestBody(email: email),
      );
      return ApiResult.success(response);
    } catch (error) { 
      return ApiResult.failure(ApiErrorHandler.handle(error)); 
    }
  }

  Future<ApiResult<ForgotPasswordResponse>> verifyResetCode(String email, String code) async {
    try {
      final response = await _apiService.newPasswordVerification(
        VerificationRequestBody(email: email, verificationCode: code),
      );
      return ApiResult.success(response);
    } catch (error) { 
      return ApiResult.failure(ApiErrorHandler.handle(error)); 
    }
  }


  Future<ApiResult<ForgotPasswordResponse>> resetPassword(ResetPasswordRequestBody body) async {
    try {
      final response = await _apiService.resetPassword(body);
      return ApiResult.success(response);
    } catch (error) { 
      return ApiResult.failure(ApiErrorHandler.handle(error)); 
    }
  }
}