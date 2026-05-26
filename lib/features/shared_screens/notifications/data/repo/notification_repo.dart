import 'package:flutter/foundation.dart';
import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/shared_screens/notifications/data/models/notification_model.dart';
import 'package:graduation_progect/hive_cache_service.dart';


class NotificationRepo {
  final ApiService _apiService;
  NotificationRepo(this._apiService);

  Future<void> saveDeviceToken(String token) async {
    try {
      await _apiService.saveDeviceToken({'token': token});
    } catch (e) {
      debugPrint('❌ Error saving device token: $e');
    }
  }


  Future<ApiResult<List<NotificationModel>>> getNotifications({
    required int latest,
  }) async {
    try {
      final response = await _apiService.getNotifications(latest);
      return ApiResult.success(response.notifications);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }


  Future<ApiResult<int>> getNewNotificationsCount() async {
    if (!ConnectivityHelper.isOnline) {
      final cached = HiveCacheService.getCachedNotificationCount();
      if (cached != null) return ApiResult.success(cached);
      return ApiResult.success(0);
    }

    if (HiveCacheService.isNotifCountFresh()) {
      final cached = HiveCacheService.getCachedNotificationCount();
      if (cached != null) return ApiResult.success(cached);
    }

    try {
      final response = await _apiService.getNewNotificationsCount();
      final count = (response['count'] as int?) ?? 0;
      await HiveCacheService.cacheNotificationCount(count);
      return ApiResult.success(count);
    } catch (error) {
      final cached = HiveCacheService.getCachedNotificationCount();
      if (cached != null) return ApiResult.success(cached);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
