
import 'package:flutter/material.dart';
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
      debugPrint('❌ Error saving token to backend: $e');
    }
  }

  /// جلب الإشعارات مع التخزين المؤقت
  Future<ApiResult<List<NotificationModel>>> getNotifications({
    required int latest,
  }) async {
    try {
      final response = await _apiService.getNotifications(latest);
      final notifications = response.notifications;


      final jsonList = notifications.map((n) => n.toJson()).toList();
      await HiveCacheService.cacheNotifications(jsonList);

      return ApiResult.success(notifications);
    } catch (error) {
      // محاولة الاسترجاع من الكاش عند الفشل
      final cached = _getCachedNotifications();
      if (cached != null) {
        return ApiResult.success(cached);
      }
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// جلب عدد الإشعارات غير المقروءة مع الكاش
  Future<ApiResult<int>> getNewNotificationsCount() async {
    try {
      final response = await _apiService.getNewNotificationsCount();
      final count = response['count'] ?? 0;
      // حفظ العدد
      await HiveCacheService.cacheNotificationCount(count);
      return ApiResult.success(count);
    } catch (error) {
      final cachedCount = HiveCacheService.getCachedNotificationCount();
      if (cachedCount != null) {
        return ApiResult.success(cachedCount);
      }
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // --- دوال مساعدة ---
  List<NotificationModel>? _getCachedNotifications() {
    final cachedList = HiveCacheService.getCachedNotifications();
    if (cachedList == null) return null;
    try {
      return cachedList
          .map((json) => NotificationModel.fromJson(json))
          .toList();
    } catch (_) {
      return null;
    }
  }
}