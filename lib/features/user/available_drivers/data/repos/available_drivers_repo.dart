import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/user/available_drivers/data/models/send_to_driver_request.dart';
import '../models/driver_model.dart';

class AvailableDriversRepo {
  final ApiService _apiService;
  AvailableDriversRepo(this._apiService);

  Future<ApiResult<List<DriverModel>>> getAvailableDrivers() async {
    try {
      final response = await _apiService.getAvailableDrivers();
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }


  Future<ApiResult<String>> sendToDriver(SendToDriverRequest body) async {
    try {
      final response = await _apiService.sendToDriver(body);
      return ApiResult.success(response['message'] ?? 'تم إرسال الطلب بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }


  
}