import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';

class ApplyToPostRepo {
  final ApiService _apiService;
  ApplyToPostRepo(this._apiService);

  Future<ApiResult<String>> applyToPost({
    required int postId,
    required double price,
    required String date, 
  }) async {
    try {
      final response = await _apiService.applyToPost({
        'post_id': postId,
        'price': price,
        'date': date,
      });
      return ApiResult.success(response['message'] ?? 'تم تقديم العرض بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}