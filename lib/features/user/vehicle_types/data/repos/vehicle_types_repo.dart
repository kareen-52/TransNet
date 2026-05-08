
import 'package:graduation_progect/connectivity_helper.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/hive_cache_service.dart';
import '../models/vehicle_type_model.dart';

/// Offline-first vehicle types repository.
///
/// Strategy:
/// 1. If there is no internet → return cached data immediately (or error if
///    no cache exists).
/// 2. If internet is available → try the API.
///    a. If API succeeds and data has changed → update cache and return fresh.
///    b. If API succeeds but data is identical → return cache (no rebuild).
///    c. If API fails but cache exists → return stale cache silently.
///    d. If API fails and no cache → return failure.
class VehicleTypesRepo {
  final ApiService _apiService;

  VehicleTypesRepo(this._apiService);

  Future<ApiResult<List<VehicleTypeModel>>> getVehicleTypes() async {
    final online =  ConnectivityHelper.isOnline;

    if (!online) {
      return _returnFromCache() ??
          ApiResult.failure(
            ApiErrorModel(
              message: 'لا يوجد اتصال بالإنترنت ولا توجد بيانات محفوظة مسبقاً',
            ),
          );
    }

    // ── Online path ──────────────────────────────────────────────────────────
    try {
      final response = await _apiService.getVehicleTypes();
      final rawList =
          response.map((v) => _vehicleToJson(v)).toList();

      if (HiveCacheService.vehicleTypesChanged(rawList)) {
        // Server data is genuinely new — persist and return fresh
        await HiveCacheService.cacheVehicleTypes(rawList);
        return ApiResult.success(response);
      } else {
        // Data unchanged — return from cache to avoid unnecessary rebuilds
        return _returnFromCache() ?? ApiResult.success(response);
      }
    } catch (error) {
      // API failed — fall back to cache if available
      return _returnFromCache() ??
          ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  ApiResult<List<VehicleTypeModel>>? _returnFromCache() {
    final cached = HiveCacheService.getCachedVehicleTypes();
    if (cached == null) return null;
    final models = cached.map(VehicleTypeModel.fromJson).toList();
    return ApiResult.success(models);
  }

  Map<String, dynamic> _vehicleToJson(VehicleTypeModel v) => {
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