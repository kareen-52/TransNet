import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/home/data/models/availability_response.dart';
import 'package:graduation_progect/features/driver/home/data/models/shipment_count_response.dart';
import 'package:graduation_progect/hive_cache_service.dart';

/// Driver home repository.
///
/// Profile image strategy: PERSISTENT CACHE + ONLINE VALIDATION.
/// - Image survives app restart (stored in Hive as Uint8List).
/// - When online, compare cached URL vs server URL.
///   If changed → download new image → update cache → return fresh bytes.
///   If unchanged → return cached bytes (no unnecessary download).
/// - When offline → return cached bytes.
class DriverHomeRepo {
  final ApiService _apiService;
  DriverHomeRepo(this._apiService);

  Future<ApiResult<AvailabilityResponse>> changeAvailability() async {
    try {
      final response = await _apiService.changeDriverAvailability();
      return ApiResult.success(AvailabilityResponse.fromJson(response));
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ShipmentCountResponse>> getShipmentCount() async {
    try {
      final response = await _apiService.countContinuousSuccessfulShipments();
      return ApiResult.success(ShipmentCountResponse.fromJson(response));
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Fetches and validates the driver's own profile image.
  ///
  /// [currentImageUrl] is the URL coming from the latest profile response.
  /// If null, we skip URL comparison and always re-download.
  Future<ApiResult<Uint8List>> getOrRefreshDriverImage(
    int driverId, {
    String? currentImageUrl,
  }) async {
    // 1. Try to serve from persistent cache first (works offline too)
    final cached = HiveCacheService.getCachedDriverImage(driverId);

    if (cached != null) {
      final cachedUrl = HiveCacheService.getCachedDriverImageUrl(driverId);

      // If online and we have a URL to compare — check for changes
      if (currentImageUrl != null && cachedUrl != null) {
        if (cachedUrl == currentImageUrl) {
          // Image hasn't changed on server → reuse cached bytes
          return ApiResult.success(cached);
        }
        // URL changed → fall through to download new image
      } else if (currentImageUrl == null) {
        // No URL to compare → serve cache if available
        return ApiResult.success(cached);
      }
    }

    // 2. Download fresh image (either no cache, or URL changed)
    try {
      final bytes = await _apiService.getDriverImage(driverId);
      final imageBytes = Uint8List.fromList(bytes);
      await HiveCacheService.cacheDriverImage(
        driverId,
        imageBytes,
        imageUrl: currentImageUrl,
      );
      debugPrint('[DriverHomeRepo] Driver image downloaded & cached for $driverId');
      return ApiResult.success(imageBytes);
    } catch (error) {
      // Download failed — if we had a cached image, return it
      if (cached != null) return ApiResult.success(cached);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Direct fetch for available drivers list — no caching (per spec).
  Future<ApiResult<Uint8List>> getDriverImage(int driverId) async {
    try {
      final response = await _apiService.getDriverImage(driverId);
      return ApiResult.success(Uint8List.fromList(response));
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
