import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/api_constants.dart';
import 'package:graduation_progect/core/networking/app_config.dart';

class TokenRefresher {
  TokenRefresher._();

  static Future<bool> refreshToken() async {
    if (kDebugMode) debugPrint('🔄 [TokenRefresher] Started refreshing token process...');

    try {
      final oldRefreshToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.refreshToken);

      if (oldRefreshToken.isEmpty) {
        if (kDebugMode) debugPrint('❌ [TokenRefresher] No refresh token found. Aborting refresh.');
        return false;
      }

      // 1. استخدام Dio منفصل ونظيف (بدون Authorization header لكي لا يرفضه Laravel مبكراً)
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: AppConfig.apiBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Accept': 'application/json',
            // تم إزالة الـ Authorization Header من هنا
          },
        ),
      );

      // 2. إرسال طلب التحديث
      final response = await refreshDio.post(
        ApiConstants.refreshToken,
        data: {'refresh_token': oldRefreshToken},
      );

      // 3. معالجة حالة النجاح 200
      if (response.statusCode == 200 && response.data != null) {
        final String? newAccessToken = response.data['access_token'];
        final String? newRefreshToken = response.data['refresh_token'];

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          // حفظ الـ Access Token الجديد دائماً
          await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, newAccessToken);
          
          // حفظ الـ Refresh Token الجديد فقط إذا أرسله الباك إند
          if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
            await SharedPrefHelper.setSecuredString(SharedPrefKeys.refreshToken, newRefreshToken);
          }

          if (kDebugMode) debugPrint('✅ [TokenRefresher] Token refreshed successfully.');
          return true;
        }
      }
      return false;

    } on DioException catch (e) {
      // 4. معالجة ردود الباك إند في حال الفشل
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final data = e.response!.data;

        if (kDebugMode) debugPrint('❌ [TokenRefresher] Failed with status: $statusCode, Data: $data');

        if (statusCode == 403 && data is Map) {
          final message = data['message'];
          if (message == 'banned' || message == 'frozen') {
            if (kDebugMode) debugPrint('🛑 [TokenRefresher] User is $message. Forcing logout.');
            return false; // سيؤدي للطرد
          }
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) debugPrint('❌ [TokenRefresher] Unexpected error: $e');
      return false;
    }
  }
}