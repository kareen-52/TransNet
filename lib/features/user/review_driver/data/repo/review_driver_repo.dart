import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';

class ReviewDriverRepo {
  final ApiService _apiService;
  ReviewDriverRepo(this._apiService);

  Future<ApiResult<String>> createReview({
    required int driverId,
    required double rate,
    required String review,
  }) async {
    try {
      final response = await _apiService.createReview({
        'driver_id': driverId,
        'rate': rate,
        'review': review,
      });
      return ApiResult.success(response['message'] ?? 'تم إضافة التقييم بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}