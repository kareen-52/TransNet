import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/home/data/models/availability_response.dart';
import 'package:graduation_progect/features/driver/home/data/models/shipment_count_response.dart';
import 'package:graduation_progect/hive_cache_service.dart';


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

  Future<ApiResult<Uint8List>> getOrRefreshDriverImage(
    int driverId, {
    String? currentImageUrl,
  }) async {
 
    final cached = HiveCacheService.getCachedDriverImage(driverId);

    if (cached != null) {
      final cachedUrl = HiveCacheService.getCachedDriverImageUrl(driverId);

   
      if (currentImageUrl != null && cachedUrl != null) {
        if (cachedUrl == currentImageUrl) {
    
          return ApiResult.success(cached);
        }
       
      } else if (currentImageUrl == null) {
     
        return ApiResult.success(cached);
      }
    }


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
     
      if (cached != null) return ApiResult.success(cached);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

 
  Future<ApiResult<Uint8List>> getDriverImage(int driverId) async {
    try {
      final response = await _apiService.getDriverImage(driverId);
      return ApiResult.success(Uint8List.fromList(response));
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
