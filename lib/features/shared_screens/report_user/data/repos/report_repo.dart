import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';

class ReportRepo {
  final ApiService _apiService;
  ReportRepo(this._apiService);

  Future<ApiResult<String>> submitReport({
    required int reportedId,
    required String type,
    required String description,
  }) async {
    try {
      final response = await _apiService.reportUser({
        'reported_id': reportedId,
        'type': type,
        'description': description,
      });
      return ApiResult.success(response['message'] ?? 'تم إرسال البلاغ بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}