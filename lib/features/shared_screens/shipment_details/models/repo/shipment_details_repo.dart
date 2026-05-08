import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/models/shipment_details_response.dart';


class ShipmentsDetailsRepo {
  final ApiService _apiService;

  ShipmentsDetailsRepo(this._apiService);

 Future<ApiResult<ShipmentDetailsResponse>> getShipmentDetails(int id) async {
  try {
    final response = await _apiService.getShipmentDetails(id);
    return ApiResult.success(response);
  } catch (error) {
    return ApiResult.failure(ApiErrorHandler.handle(error));
  }
}
}
