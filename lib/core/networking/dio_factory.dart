// import 'package:dio/dio.dart';
// import 'package:graduation_progect/core/networking/auth_interceptor.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class DioFactory {
//   DioFactory._();
//   static Dio? _dio;

//   static Future<Dio> getDio() async {
//     if (_dio == null) {
//       _dio = Dio();
//       _dio!
//         ..options.connectTimeout = const Duration(seconds: 30)
//         ..options.receiveTimeout = const Duration(seconds: 30);

//       _dio!.interceptors.add(AuthInterceptor());

//       addDioInterceptor();
//     }
//     return _dio!;
//   }

//   static void addDioInterceptor() {
//     if (_dio?.interceptors.whereType<PrettyDioLogger>().isEmpty ?? true) {
//       _dio?.interceptors.add(
//         PrettyDioLogger(
//           requestBody: true,
//           requestHeader: true,
//           responseHeader: true,
//         ),
//       );
//     }
//   }

//   static void setTokenInHeaderAfterLogin(String token) {
//     if (_dio != null) {
//       _dio!.options.headers['Authorization'] = 'Bearer $token';
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:graduation_progect/core/networking/auth_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();
  static Dio? _dio;

  // ✅ شيلنا async لأن ما في شي ينتظره فعلياً
  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio();
      _dio!
        ..options.connectTimeout = const Duration(seconds: 30)
        ..options.receiveTimeout = const Duration(seconds: 30);

      _dio!.interceptors.add(AuthInterceptor());
      addDioInterceptor();
    }
    return _dio!;
  }

  static void addDioInterceptor() {
    if (_dio?.interceptors.whereType<PrettyDioLogger>().isEmpty ?? true) {
      _dio?.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }
  }

  static void setTokenInHeaderAfterLogin(String token) {
    if (_dio != null) {
      _dio!.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
