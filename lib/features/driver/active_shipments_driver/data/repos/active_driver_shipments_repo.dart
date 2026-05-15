import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import '../models/active_driver_shipment_model.dart';


class ActiveDriverShipmentsRepo {
  final ApiService _apiService;

  ActiveDriverShipmentsRepo(this._apiService);

  Future<ApiResult<List<ActiveDriverShipmentModel>>> getActiveShipments() async {
    try {
      final dynamic response = await _apiService.getActiveShipmentsForDriver();

      if (response is Map<String, dynamic> && response.containsKey('result')) {
        return const ApiResult.success([]);
      }

      if (response is List) {
        final shipments = response
            .map((e) => ActiveDriverShipmentModel.fromJson(
                  e as Map<String, dynamic>,
                ))
            .toList();
        return ApiResult.success(shipments);
      }

      return const ApiResult.success([]);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
