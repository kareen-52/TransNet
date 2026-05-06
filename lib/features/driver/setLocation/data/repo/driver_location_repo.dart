import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/setLocation/data/models/driver_set_location_request.dart';
import 'package:graduation_progect/features/driver/setLocation/data/models/driver_set_location_response.dart';

class DriverLocationRepo {
  final ApiService _apiService;

  DriverLocationRepo(this._apiService);

  Future<ApiResult<DriverSetLocationResponse>> setLocation(
      DriverSetLocationRequest request) async {
    try {
      final response = await _apiService.driverSetLocation(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}