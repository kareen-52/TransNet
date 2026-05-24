import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
import 'package:graduation_progect/hive_cache_service.dart';

class DriverShipmentsRepo {
  final ApiService _apiService;
  DriverShipmentsRepo(this._apiService);

  Future<ApiResult<DriverShipmentsResponse>> getShipments(int page) async {
    if (!ConnectivityHelper.isOnline) {
      return _fromCache(page) ??
          ApiResult.failure(
            ApiErrorModel(message: 'لا يوجد اتصال بالإنترنت'),
          );
    }

    try {
      final response = await _apiService.getDriverShipments(page);
      await _toCache(page, response);
      return ApiResult.success(response);
    } catch (error) {
      return _fromCache(page) ??
          ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<void> clearCache() => HiveCacheService.clearDriverShipmentPages();



  Future<void> _toCache(int page, DriverShipmentsResponse r) async {
    try {
      await HiveCacheService.cacheDriverShipmentsPage(page, r.toJson());
    } catch (_) {}
  }

  ApiResult<DriverShipmentsResponse>? _fromCache(int page) {
    final json = HiveCacheService.getCachedDriverShipmentsPage(page);
    if (json == null) return null;
    try {
      return ApiResult.success(DriverShipmentsResponse.fromJson(json));
    } catch (_) {
      return null;
    }
  }
}
