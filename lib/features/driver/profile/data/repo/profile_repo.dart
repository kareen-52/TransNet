import 'package:flutter/foundation.dart';
import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/profile/data/models/edit_profile_request.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/hive_cache_service.dart';

/// Profile repository — ONLINE FIRST + CACHE FALLBACK. No TTL.
///
/// When online  → always fetch fresh from server, update cache, return server data.
/// When offline → return cached profile (or error if no cache).
class ProfileRepo {
  final ApiService _apiService;
  ProfileRepo(this._apiService);

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
      } catch (e) {
        debugPrint('[ProfileRepo] cache write failed: $e');
      }
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
      final message = response['message'] as String? ?? 'تمت العملية بنجاح';
      await HiveCacheService.clearProfile();
      return ApiResult.success(message);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> attachGovernorate(int govId) async {
    try {
      final response = await _apiService.attachGovernorate({'gov_id': govId.toString()});
      await HiveCacheService.clearProfile();
      return ApiResult.success(response['message'] as String? ?? 'تمت الإضافة بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> detachGovernorate(int govId) async {
    try {
      final response = await _apiService.detachGovernorate({'gov_id': govId.toString()});
      await HiveCacheService.clearProfile();
      return ApiResult.success(response['message'] as String? ?? 'تم الحذف بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // ── Private helpers ─────────────────────────────────────────────────────────

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
    final user  = r.user;
    final car   = r.car;
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
      'driver_governorates':
          r.driverGovernorates?.map((g) => {'id': g.id, 'name': g.name}).toList() ?? [],
      'average_rate': r.averageRate,
      'badge': badge == null
          ? null
          : {'level': badge.level, 'name': badge.name, 'text': badge.text},
      'statisics': stats?.toJson(),
    };
  }
}
