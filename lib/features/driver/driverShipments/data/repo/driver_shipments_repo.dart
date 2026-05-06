import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';

class DriverShipmentsRepo {
  final ApiService _apiService;

  DriverShipmentsRepo(this._apiService);

  Future<ApiResult<DriverShipmentsResponse>> getShipments(int page) async {
    try {
      final response = await _apiService.getDriverShipments(page);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}