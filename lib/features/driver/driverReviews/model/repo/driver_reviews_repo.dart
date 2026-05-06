import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/driverReviews/model/review_response.dart';

class DriverReviewsRepo {
  final ApiService _apiService;

  DriverReviewsRepo(this._apiService);

  Future<ApiResult<ReviewResponse>> getDriverReviews(int driverId) async {
    try {
      final response = await _apiService.getDriverReviews(driverId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}