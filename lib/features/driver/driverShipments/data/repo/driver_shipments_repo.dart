// lib/features/driver/driverShipments/data/repo/driver_shipments_repo.dart
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
import 'package:graduation_progect/hive_cache_service.dart';

class DriverShipmentsRepo {
  final ApiService _apiService;

  DriverShipmentsRepo(this._apiService);

  Future<ApiResult<DriverShipmentsResponse>> getShipments(int page) async {
    try {
      final response = await _apiService.getDriverShipments(page);
      await _cachePage(page, response);
      return ApiResult.success(response);
    } catch (error) {
      final cached = _getCachedPage(page);
      if (cached != null) {
        return ApiResult.success(cached);
      }
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<DriverShipmentsResponse>> getClientrShipments(int page) async {
    try {
      final response = await _apiService.getClientrShipments(page);
      await _cachePage(page, response);
      return ApiResult.success(response);
    } catch (error) {
      final cached = _getCachedPage(page);
      if (cached != null) {
        return ApiResult.success(cached);
      }
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }


  Future<void> _cachePage(int page, DriverShipmentsResponse response) async {
    try {
      final json = response.toJson();
      await HiveCacheService.cacheShipmentsPage(page, json);
    } catch (_) {}
  }

  DriverShipmentsResponse? _getCachedPage(int page) {
    final json = HiveCacheService.getCachedShipmentsPage(page);
    if (json == null) return null;
    try {
      return DriverShipmentsResponse.fromJson(json);
    } catch (_) {
      return null;
    }
  }
}