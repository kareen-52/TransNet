import 'package:graduation_progect/connectivity_helper.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
import 'package:graduation_progect/hive_cache_service.dart';

/// Client-only shipments repository.
/// Uses client_shipments_box — completely isolated from driver shipments.
///
/// Policy: ONLINE-FIRST + OFFLINE CACHE. No blocking TTL.
/// Online  → fetch latest → update cache → return fresh data.
/// Offline → return cached page or failure.
class ClientShipmentsRepo {
  final ApiService _apiService;
  ClientShipmentsRepo(this._apiService);

  Future<ApiResult<DriverShipmentsResponse>> getShipments(int page) async {
    if (!ConnectivityHelper.isOnline) {
      return _fromCache(page) ??
          ApiResult.failure(
            ApiErrorModel(message: 'لا يوجد اتصال بالإنترنت ولا توجد بيانات محفوظة'),
          );
    }

    try {
      final response = await _apiService.getClientrShipments(page);
      await _cachePage(page, response);
      return ApiResult.success(response);
    } catch (error) {
      return _fromCache(page) ??
          ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Invalidate all cached pages (call after shipment status changes).
  Future<void> invalidateCache() =>
      HiveCacheService.clearClientShipmentPages();

  // ── Private ───────────────────────────────────────────────────────────────

  Future<void> _cachePage(int page, DriverShipmentsResponse response) async {
    try {
      await HiveCacheService.cacheClientShipmentsPage(page, response.toJson());
    } catch (_) {}
  }

  ApiResult<DriverShipmentsResponse>? _fromCache(int page) {
    final json = HiveCacheService.getCachedClientShipmentsPage(page);
    if (json == null) return null;
    try {
      return ApiResult.success(DriverShipmentsResponse.fromJson(json));
    } catch (_) {
      return null;
    }
  }
}
