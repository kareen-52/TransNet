import 'package:dio/dio.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/shared_screens/login/data/models/login_request.dart';
import 'package:graduation_progect/features/shared_screens/login/data/models/login_response.dart';

class LoginRepo {
  final ApiService _apiService;
  LoginRepo(this._apiService);

  Future<ApiResult<LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      final response = await _apiService.login(loginRequest);
      return ApiResult.success(response);
    } on DioException catch (error) {
    
      ApiErrorModel apiError = ApiErrorHandler.handle(error);
      final statusCode = error.response?.statusCode;
      final message = apiError.getAllErrorMessages();

      if (statusCode == 403) {
        String? errorType;
        if (message.contains('حظر')) {
          errorType = 'banned';
        } else if (message.contains('تجميد') || message.contains('التكاليف')) {
          errorType = 'frozen';
        } else if (message.contains('تحقق') || message.contains('تفعيل') || message.contains('بريدك الإلكتروني')) {
          errorType = 'unverified';
        }
        apiError = ApiErrorModel(
          message: message,
          code: statusCode,
          type: errorType,
        );
      } else {
        apiError = ApiErrorModel(
          message: apiError.message,
          errors: apiError.errors,
          code: statusCode ?? apiError.code,
          type: apiError.type,
        );
      }
      return ApiResult.failure(apiError);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}