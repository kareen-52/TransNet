import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/profile/data/models/edit_profile_request.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';

class ProfileRepo {
  final ApiService _apiService;
  ProfileRepo(this._apiService);

  // جلب البيانات
  Future<ApiResult<ProfileResponse>> getProfile() async {
    try {
      final response = await _apiService.getProfileData();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // تعديل الملف الشخصي (للسائق نرسل الهاتف فقط)
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
      
      // نسحب الرسالة من الـ JSON مباشرة
      final message = response['message'] as String? ?? "تمت العملية بنجاح";
      
      return ApiResult.success(message);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
  Future<ApiResult<String>> attachGovernorate(int govId) async {
  try {
    final response = await _apiService.attachGovernorate({'gov_id': govId.toString()});
    final message = response['message'] as String? ?? "تمت الإضافة بنجاح";
    return ApiResult.success(message);
  } catch (error) {
    return ApiResult.failure(ApiErrorHandler.handle(error));
  }
}

Future<ApiResult<String>> detachGovernorate(int govId) async {
  try {
    final response = await _apiService.detachGovernorate({'gov_id': govId.toString()});
    final message = response['message'] as String? ?? "تم الحذف بنجاح";
    return ApiResult.success(message);
  } catch (error) {
    return ApiResult.failure(ApiErrorHandler.handle(error));
  }
}
}