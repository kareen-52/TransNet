import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/instant_orders/data/models/instant_order_model.dart';

class InstantOrdersRepo {
  final ApiService _apiService;
  InstantOrdersRepo(this._apiService);

  Future<ApiResult<List<InstantOrderModel>>> getPendingRequests() async {
    try {
      final response = await _apiService.getRequestsForDriver();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> respondToRequest({required int userId, required bool accept}) async {
    try {
      final response = await _apiService.respondToRequest({
        'user_id': userId,
        'action': accept ? 1 : 0,
      });
      return ApiResult.success(response['message'] ?? 'تمت العملية بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}