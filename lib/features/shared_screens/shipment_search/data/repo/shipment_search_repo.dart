import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
import 'package:graduation_progect/features/shared_screens/shipment_search/data/models/search_shipments_request.dart';

class ShipmentSearchRepo {
  final ApiService _apiService;
  ShipmentSearchRepo(this._apiService);

  Future<ApiResult<List<ShipmentModel>>> searchByDate({
    required String startDate,
    required String endDate,
  }) async {
    try {
      final request = SearchShipmentsRequest(
        startDate: startDate,
        endDate: endDate,
      );
      final list = await _apiService.searchShipmentsByDate(request);
      return ApiResult.success(list);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}