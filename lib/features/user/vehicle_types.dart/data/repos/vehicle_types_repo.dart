import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import '../models/vehicle_type_model.dart';

class VehicleTypesRepo {
  final ApiService _apiService;
  VehicleTypesRepo(this._apiService);

  Future<ApiResult<List<VehicleTypeModel>>> getVehicleTypes() async {
    try {
      final response = await _apiService.getVehicleTypes();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}