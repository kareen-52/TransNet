import 'package:dio/dio.dart';
import 'package:graduation_progect/core/networking/app_config.dart';
import 'package:graduation_progect/core/networking/auth_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();
  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: AppConfig.apiBaseUrl, 
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      _dio!.interceptors.add(AuthInterceptor(_dio!));

      addDioInterceptor();
    }
    return _dio!;
  }

  static void addDioInterceptor() {
    assert(() {
      if (_dio?.interceptors.whereType<PrettyDioLogger>().isEmpty ?? true) {
        _dio?.interceptors.add(
          PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            responseHeader: false,
            responseBody: true,
            error: true,
            compact: true,
          ),
        );
      }
      return true;
    }());
  }

  static void setTokenInHeaderAfterLogin(String token) {
    if (_dio != null) {
      _dio!.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}