import 'dart:typed_data';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/home/data/models/availability_response.dart';
import 'package:graduation_progect/features/driver/home/data/models/shipment_count_response.dart';

class DriverHomeRepo {
  final ApiService _apiService;
  DriverHomeRepo(this._apiService);


  Future<ApiResult<AvailabilityResponse>> changeAvailability() async {
    try {
      final response = await _apiService.changeDriverAvailability();
      final data = AvailabilityResponse.fromJson(response);
      return ApiResult.success(data);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }


  Future<ApiResult<ShipmentCountResponse>> getShipmentCount() async {
    try {
      final  response = await _apiService.countContinuousSuccessfulShipments();
      final data = ShipmentCountResponse.fromJson(response );
      return ApiResult.success(data);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<Uint8List>> getDriverImage(int driverId) async {
    try {
      final response = await _apiService.getDriverImage(driverId);
      return ApiResult.success(Uint8List.fromList(response));
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
      return ApiResult.success(response['message'] ?? 'تم العملية بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}