import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/shipment_model.dart';
import '../models/create_shipment_request_body.dart';
import '../models/governorate_model.dart';

class CreateShipmentRepo {
  final ApiService _apiService;

  CreateShipmentRepo(this._apiService);

  Future<ApiResult<List<GovernorateModel>>> getGovernorates() async {
    try {
      final response = await _apiService.getGovernorates();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> createShipment(CreateShipmentRequestBody body,) async {
    try {
      final response = await _apiService.createShipment(body);
      return ApiResult.success(response['message'] ?? 'تم إنشاء الشحنة بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }



  Future<ApiResult<dynamic>> updateShipment(Map<String, dynamic> body) async {
    try {
      final response = await _apiService.updateShipment(body);
      return ApiResult.success(response['message'] ?? 'تم التعديل بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> deleteShipment() async {
    try {
      final response = await _apiService.deleteShipment();
      return ApiResult.success(response['message'] ?? 'تم حذف الطلب بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ShipmentModel>> getActiveShipment() async {
    try {
      final response = await _apiService.getShipment();
      return ApiResult.success(ShipmentModel.fromJson(response['data']));
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<dynamic>> extendShipment() async {
    try {
      final response = await _apiService.extendShipment();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }


  Future<ApiResult<String>> cancelRequestForDriver(int driverId) async {
    try {
      final response = await _apiService.cancelRequestForDriver(driverId);
      return ApiResult.success(response['message'] ?? 'تم إلغاء الطلب بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
