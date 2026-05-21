import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/force_logout_handler.dart';
import 'package:graduation_progect/core/networking/token_refresher.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;
  
  final _requestsQueue = <Map<String, dynamic>>[];

  AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      if (kDebugMode) debugPrint('🔐 [AuthInterceptor] Attached token to request: ${options.path}');
    } else {
      if (kDebugMode) debugPrint('⚠️ [AuthInterceptor] No token found for request: ${options.path}');
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 1. التحقق من الشرط المزدوج: 401 + رسالة "Unauthenticated."
    bool isTokenExpired = false;
    
    if (err.response?.statusCode == 401) {
      final data = err.response?.data;
      
      if (data is Map && (data['message'] == 'Unauthenticated.' || data['message'] == 'Unauthenticated')) {
        isTokenExpired = true;
        if (kDebugMode) {
          debugPrint('🔄 [AuthInterceptor] Detected 401 Unauthenticated for ${err.requestOptions.path}. Will try to refresh token.');
        }
      } else {
        if (kDebugMode) debugPrint('🚫 [AuthInterceptor] 401 but message is not Unauthenticated (${data?['message']}). Passing error.');
      }
    }

    if (!isTokenExpired) {
      return handler.next(err);
    }

    // 2. إذا كنا نقوم بتحديث التوكن حالياً، ضع الطلب في الطابور
    if (_isRefreshing) {
      if (kDebugMode) debugPrint('⏳ [AuthInterceptor] Refreshing already in progress. Queuing request: ${err.requestOptions.path}');
      _requestsQueue.add({
        'options': err.requestOptions, 
        'handler': handler, 
        'error': err
      });
      return; 
    }

    _isRefreshing = true;
    if (kDebugMode) debugPrint('🔁 [AuthInterceptor] Starting token refresh process...');

    try {
      final isRefreshed = await TokenRefresher.refreshToken();

      if (isRefreshed) {
        final newToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
        if (kDebugMode) {
          debugPrint('✅ [AuthInterceptor] Token refreshed successfully. New access token: ${newToken.substring(0, 10)}...');
        }
        
        // 4. إعادة إرسال الطلب الأصلي
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        if (kDebugMode) debugPrint('🔁 [AuthInterceptor] Retrying original request: ${err.requestOptions.path}');
        try {
          final response = await dio.fetch(err.requestOptions);
          handler.resolve(response);
          if (kDebugMode) debugPrint('✔️ [AuthInterceptor] Original request succeeded after refresh.');
        } catch (e) {
          if (kDebugMode) debugPrint('❌ [AuthInterceptor] Original request failed after refresh: $e');
          handler.next(e as DioException);
        }

        // 5. إعادة إرسال جميع الطلبات في الطابور
        if (_requestsQueue.isNotEmpty) {
          if (kDebugMode) debugPrint('📦 [AuthInterceptor] Retrying ${_requestsQueue.length} queued requests...');
          for (var item in _requestsQueue) {
            final reqOptions = item['options'] as RequestOptions;
            final reqHandler = item['handler'] as ErrorInterceptorHandler;
            final reqError = item['error'] as DioException;
            
            reqOptions.headers['Authorization'] = 'Bearer $newToken';
            try {
              final res = await dio.fetch(reqOptions);
              reqHandler.resolve(res);
              if (kDebugMode) debugPrint('✔️ [AuthInterceptor] Queued request to ${reqOptions.path} succeeded.');
            } catch (e) {
              if (kDebugMode) debugPrint('❌ [AuthInterceptor] Queued request to ${reqOptions.path} failed: $e');
              reqHandler.next(e is DioException ? e : reqError);
            }
          }
        }
      } else {
        if (kDebugMode) debugPrint('🛑 [AuthInterceptor] Token refresh failed. Logging out...');
        // فشل التحديث -> إرجاع كل الطلبات في الطابور كأخطاء
        for (var item in _requestsQueue) {
          final reqHandler = item['handler'] as ErrorInterceptorHandler;
          final reqError = item['error'] as DioException;
          reqHandler.next(reqError);
        }
        await ForceLogoutHandler.forceLogout();
        handler.next(err);
      }
    } catch (e) {
      if (kDebugMode) debugPrint('💥 [AuthInterceptor] Unexpected error during refresh: $e');
      for (var item in _requestsQueue) {
        final reqHandler = item['handler'] as ErrorInterceptorHandler;
        final reqError = item['error'] as DioException;
        reqHandler.next(reqError);
      }
      await ForceLogoutHandler.forceLogout();
      handler.next(err);
    } finally {
      _requestsQueue.clear();
      _isRefreshing = false;
      if (kDebugMode) debugPrint('🏁 [AuthInterceptor] Refresh process ended. Queue cleared. isRefreshing = false');
    }
  }
}