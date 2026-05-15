import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';

class DriverTrackingRepo {
  final ApiService _apiService;

  DriverTrackingRepo(this._apiService);

  Future<ApiResult<String>> confirmPickup({required int shipmentId, required String qrPin}) async {
    try {
      final response = await _apiService.confirmPickup({
        'shipment_id': shipmentId,
        'qr_pin': qrPin,
      });
      return ApiResult.success(response['message'] ?? 'تم استلام الشحنة بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> confirmDelivery({required int shipmentId, required String pin}) async {
    try {
      final response = await _apiService.confirmDelivery({
        'shipment_id': shipmentId,
        'pin': pin,
      });
      return ApiResult.success(response['message'] ?? 'تم تسليم الشحنة بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}