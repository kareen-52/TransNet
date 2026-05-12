import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import '../models/active_order_model.dart';


class ActiveOrdersRepo {
  final ApiService _apiService;

  ActiveOrdersRepo(this._apiService);

  Future<ApiResult<List<ActiveOrderModel>>> getActiveOrders() async {
    try {
      final dynamic response = await _apiService.getActiveOrders();

      if (response is Map<String, dynamic> &&
          response.containsKey('result')) {
        return const ApiResult.success([]);
      }

      if (response is List) {
        final orders = response
            .map(
              (e) => ActiveOrderModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        return ApiResult.success(orders);
      }

      return const ApiResult.success([]);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
