// ============================================================
// lib/core/networking/token_refresher.dart
// ============================================================
// إصلاحات:
// 1. Dio instance له timeout محدد (لا يتعلق للأبد)
// 2. معالجة أخطاء واضحة ترجع false بدل throw
// ============================================================

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/app_config.dart';

class TokenRefresher {
  TokenRefresher._();

  static Future<bool> refreshToken() async {
    final refreshToken = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.refreshToken,
    );

    if (refreshToken.isEmpty) {
      if (kDebugMode) debugPrint('[TokenRefresher] No refresh token found');
      return false;
    }

    // Dio منفصل بدون interceptors للتجنب التكرار اللانهائي
    final refreshDio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );

    try {
      final response = await refreshDio.post(
        'auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      final newToken = response.data?['access_token'] as String?;
      final newRefresh = response.data?['refresh_token'] as String?;

      if (newToken == null || newToken.isEmpty) {
        if (kDebugMode) debugPrint('[TokenRefresher] Empty token in response');
        return false;
      }

      await Future.wait([
        SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, newToken),
        if (newRefresh != null && newRefresh.isNotEmpty)
          SharedPrefHelper.setSecuredString(
              SharedPrefKeys.refreshToken, newRefresh),
      ]);

      if (kDebugMode) debugPrint('[TokenRefresher] Token refreshed ✓');
      return true;
    } on DioException catch (e) {
      if (kDebugMode) debugPrint('[TokenRefresher] DioError: ${e.type}');
      return false;
    } catch (e) {
      if (kDebugMode) debugPrint('[TokenRefresher] Unexpected error: $e');
      return false;
    } finally {
      refreshDio.close();
    }
  }
}
