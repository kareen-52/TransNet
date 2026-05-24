import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/profile/data/models/edit_profile_request.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/hive_cache_service.dart';

class ClientProfileRepo {
  final ApiService _apiService;
  ClientProfileRepo(this._apiService);

  Future<ApiResult<ProfileResponse>> getProfile() async {
    if (!ConnectivityHelper.isOnline) {
      return _fromCache() ??
          ApiResult.failure(
            ApiErrorModel(message: 'لا يوجد اتصال بالإنترنت ولا توجد بيانات محفوظة'),
          );
    }

    try {
      final response = await _apiService.getProfileData();
      try {
        await HiveCacheService.cacheProfile(_toJson(response));
      } catch (_) {}
      return ApiResult.success(response);
    } catch (error) {
      return _fromCache() ?? ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> updateProfile({
    required String phone,
    String? fName,
    String? lName,
  }) async {
    try {
      final response = await _apiService.editProfile(
        EditProfileRequest(phoneNumber: phone, firstName: fName, lastName: lName),
      );
      await HiveCacheService.clearProfile();
      return ApiResult.success(response['message'] as String? ?? 'تمت العملية بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  ApiResult<ProfileResponse>? _fromCache() {
    final cached = HiveCacheService.getCachedProfile();
    if (cached == null) return null;
    try {
      return ApiResult.success(ProfileResponse.fromJson(cached));
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> _toJson(ProfileResponse r) {
    final user = r.user;
    return {
      'user': user == null
          ? null
          : {
              'id': user.id,
              'driver_id': user.driverId,
              'first_name': user.firstName,
              'last_name': user.lastName,
              'user_number': user.userNumber,
              'phone_number': user.phoneNumber,
         
            },
    };
  }
}
