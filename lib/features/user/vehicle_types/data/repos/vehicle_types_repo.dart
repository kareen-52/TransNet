import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/hive_cache_service.dart';
import '../models/vehicle_type_model.dart';

class VehicleTypesRepo {
  final ApiService _apiService;
  VehicleTypesRepo(this._apiService);

  Future<ApiResult<List<VehicleTypeModel>>> getVehicleTypes() async {
    if (!ConnectivityHelper.isOnline) {
      return _fromCache() ??
          ApiResult.failure(
            ApiErrorModel(
              message: 'لا يوجد اتصال بالإنترنت ولا توجد بيانات محفوظة',
            ),
          );
    }

    try {
      final response = await _apiService.getVehicleTypes();
      final rawList  = response.map(_toJson).toList();

      if (HiveCacheService.vehicleTypesChanged(rawList)) {
        // Data changed on server → update cache and return fresh
        await HiveCacheService.cacheVehicleTypes(rawList);
        return ApiResult.success(response);
      }
      // Data unchanged → serve from cache (avoids unnecessary UI rebuild)
      return _fromCache() ?? ApiResult.success(response);
    } catch (error) {
      return _fromCache() ?? ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // ── Private ─────────────────────────────────────────────────────────────────

  ApiResult<List<VehicleTypeModel>>? _fromCache() {
    final cached = HiveCacheService.getCachedVehicleTypes();
    if (cached == null) return null;
    try {
      return ApiResult.success(cached.map(VehicleTypeModel.fromJson).toList());
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> _toJson(VehicleTypeModel v) => {
        'id': v.id,
        'type': v.type,
        'description': v.description,
        'vehicle_coefficient': v.vehicleCoefficient,
        'avg_fuel_consumption': v.avgFuelConsumption,
        'base_fare': v.baseFare,
        'min_weight': v.minWeight,
        'max_weight': v.maxWeight,
        'min_length': v.minLength,
        'max_length': v.maxLength,
        'min_width': v.minWidth,
        'max_width': v.maxWidth,
        'min_height': v.minHeight,
        'max_height': v.maxHeight,
      };
}
