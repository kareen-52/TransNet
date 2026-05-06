import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/shared_screens/notifications/data/models/notification_model.dart';

class NotificationRepo {
  final ApiService _apiService;
  NotificationRepo(this._apiService);

  Future<void> saveDeviceToken(String token) async {
    try {
      print("📡 Calling API to save token: $token");
      await _apiService.saveDeviceToken({'token': token});
      print("✅ API Call Finished");
    } catch (e) {
      print("❌ Error saving token to backend: $e");
    }
  }

  Future<ApiResult<List<NotificationModel>>> getAllNotifications() async {
    try {
      final response = await _apiService.getAllNotifications();
      return ApiResult.success(response.notifications);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<int>> getNewNotificationsCount() async {
    try {
      final response = await _apiService.getNewNotificationsCount();

      return ApiResult.success(response['count'] ?? 0);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}