import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/api_constants.dart';
import 'package:graduation_progect/core/networking/app_config.dart';

enum RefreshResult {
  success,   
  failed,   
  banned,    
}

class TokenRefresher {
  TokenRefresher._();

  static Future<RefreshResult> refreshToken() async {
    if (kDebugMode) debugPrint('🔄 [TokenRefresher] Started refreshing token process...');

    try {
      final oldRefreshToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.refreshToken);

      if (oldRefreshToken.isEmpty) {
        if (kDebugMode) debugPrint('❌ [TokenRefresher] No refresh token found. Aborting refresh.');
        return RefreshResult.failed;
      }

      final refreshDio = Dio(
        BaseOptions(
          baseUrl: AppConfig.apiBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      final response = await refreshDio.post(
        ApiConstants.refreshToken,
        data: {'refresh_token': oldRefreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final String? newAccessToken = response.data['access_token'];
        final String? newRefreshToken = response.data['refresh_token'];

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, newAccessToken);
          if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
            await SharedPrefHelper.setSecuredString(SharedPrefKeys.refreshToken, newRefreshToken);
          }
          if (kDebugMode) debugPrint('✅ [TokenRefresher] Token refreshed successfully.');
          return RefreshResult.success;
        }
      }
      return RefreshResult.failed;

    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final data = e.response!.data;

        if (kDebugMode) debugPrint('❌ [TokenRefresher] Failed with status: $statusCode, Data: $data');

        // حالة 403 مع رسالة banned أو frozen
        if (statusCode == 403 && data is Map) {
          final message = data['message']?.toString().toLowerCase();
          if (message == 'banned') {
            if (kDebugMode) debugPrint('🛑 [TokenRefresher] Account is $message. Will force logout with security message.');
            return RefreshResult.banned;
          }
        }
      }
      return RefreshResult.failed;
    } catch (e) {
      if (kDebugMode) debugPrint('❌ [TokenRefresher] Unexpected error: $e');
      return RefreshResult.failed;
    }
  }
}