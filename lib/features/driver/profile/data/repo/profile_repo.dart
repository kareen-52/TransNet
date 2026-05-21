import 'package:flutter/foundation.dart';

import 'package:graduation_progect/core/networking/api_error_handler.dart';

import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/profile/data/models/edit_profile_request.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/hive_cache_service.dart';

class ProfileRepo {
  final ApiService _apiService;

  ProfileRepo(this._apiService);

Future<ApiResult<ProfileResponse>> getProfile() async {
  try {
    // حاول جلب البروفايل من السيرفر أولاً
    final response = await _apiService.getProfileData();
    final rawMap = _profileToJson(response);

    // احفظ في الكاش دائماً لتكون متاحة offline
    try {
      await HiveCacheService.cacheProfile(rawMap);
      debugPrint('[ProfileRepo] Profile cached successfully');
    } catch (e) {
      debugPrint('[ProfileRepo] Cache write fail: $e');
    }

    return ApiResult.success(response);
  } catch (error) {
    // فشل الاتصال؟ نرجع للكاش
    final cached = _returnFromCache();
    if (cached != null) {
      debugPrint('[ProfileRepo] Using cached profile');
      return cached;
    }
    return ApiResult.failure(ApiErrorHandler.handle(error));
  }
}

  /// Updates the profile on the server and invalidates the local cache so
  /// the next [getProfile] call fetches fresh data.
  Future<ApiResult<String>> updateProfile({
    required String phone,
    String? fName,
    String? lName,
  }) async {
    try {
      final requestBody = EditProfileRequest(
        phoneNumber: phone,
        firstName: fName,
        lastName: lName,
      );

      final response = await _apiService.editProfile(requestBody);
      final message = response['message'] as String? ?? 'تمت العملية بنجاح';

      // Invalidate cache so next read reflects the updated data
      await HiveCacheService.clearProfile();

      return ApiResult.success(message);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> attachGovernorate(int govId) async {
    try {
      final response = await _apiService.attachGovernorate(
        {'gov_id': govId.toString()},
      );
      final message = response['message'] as String? ?? 'تمت الإضافة بنجاح';
      await HiveCacheService.clearProfile(); // profile changed
      return ApiResult.success(message);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> detachGovernorate(int govId) async {
    try {
      final response = await _apiService.detachGovernorate(
        {'gov_id': govId.toString()},
      );
      final message = response['message'] as String? ?? 'تم الحذف بنجاح';
      await HiveCacheService.clearProfile(); // profile changed
      return ApiResult.success(message);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  ApiResult<ProfileResponse>? _returnFromCache() {
    final cached = HiveCacheService.getCachedProfile();
    if (cached == null) return null;
    return ApiResult.success(ProfileResponse.fromJson(cached));
  }

  /// Converts [ProfileResponse] to a plain JSON map for Hive storage.
  /// We intentionally build this manually (not relying on generated toJson)
  /// because several nested classes do not yet expose toJson.
  Map<String, dynamic> _profileToJson(ProfileResponse r) {
    final user = r.user;
    final car = r.car;
    final badge = r.badge;
    final stats = r.statistics;

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
      'car': car == null
          ? null
          : {
              'id': car.id,
              'vehicle_type_id': car.vehicleTypeId,
              'manufacturer': car.manufacturer,
              'model': car.model,
              'year_of_manufacture': car.yearOfManufacture,
              'color': car.color,
              'license_plate_number': car.licensePlateNumber,
              'vehicle_type': car.vehicleType == null
                  ? null
                  : {
                      'id': car.vehicleType!.id,
                      'type': car.vehicleType!.type,
                      'description': car.vehicleType!.description,
                    },
            },
      'driver_governorates': r.driverGovernorates
              ?.map((g) => {'id': g.id, 'name': g.name})
              .toList() ??
          [],
      'average_rate': r.averageRate,
      'badge': badge == null
          ? null
          : {
              'level': badge.level,
              'name': badge.name,
              'text': badge.text,
            },
      'statisics': stats?.toJson(),
    };
  }
}