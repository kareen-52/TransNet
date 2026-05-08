// ============================================================
// lib/core/networking/dio_factory.dart
// ============================================================
// إصلاحات:
// 1. PrettyDioLogger محجوب بـ assert() — لا يعمل في Release
// 2. BaseUrl يأتي من AppConfig (--dart-define) مش hardcoded
// 3. setTokenInHeaderAfterLogin باقية للتوافق مع الكود الحالي
// ============================================================

import 'package:dio/dio.dart';
import 'package:graduation_progect/core/networking/app_config.dart';
import 'package:graduation_progect/core/networking/auth_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio != null) return _dio!;

    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio!.interceptors.add(AuthInterceptor());

    // PrettyDioLogger يعمل فقط في Debug — assert() يُزال تلقائياً من Release
    assert(() {
      _dio!.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: false, // مش محتاجين response headers عادةً
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
      return true;
    }());

    return _dio!;
  }

  /// تُستدعى بعد نجاح تسجيل الدخول لتحديث الـ Authorization header
  static void setTokenInHeaderAfterLogin(String token) {
    _dio?.options.headers['Authorization'] = 'Bearer $token';
  }

}
