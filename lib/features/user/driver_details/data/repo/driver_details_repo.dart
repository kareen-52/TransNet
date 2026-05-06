import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import '../models/driver_details_model.dart';

class DriverDetailsRepo {
  final ApiService _apiService;
  DriverDetailsRepo(this._apiService);

  Future<ApiResult<DriverDetailsModel>> getDriverDetails(int id) async {
    try {
      final response = await _apiService.getDriverDetails(id);
      return ApiResult.success(DriverDetailsModel.fromJson(response));
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}