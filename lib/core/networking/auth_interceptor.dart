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
      if (kDebugMode) debugPrint(' [AuthInterceptor] Attached token to request: ${options.path}');
    } else {
      if (kDebugMode) debugPrint(' [AuthInterceptor] No token found for request: ${options.path}');
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    bool isTokenExpired = false;

    if (err.response?.statusCode == 401) {
      final data = err.response?.data;
      if (data is Map && (data['message'] == 'Unauthenticated.' || data['message'] == 'Unauthenticated')) {
        isTokenExpired = true;
        if (kDebugMode) debugPrint(' [AuthInterceptor] Detected 401 Unauthenticated. Will try to refresh token.');
      }
    }

    if (!isTokenExpired) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      if (kDebugMode) debugPrint(' [AuthInterceptor] Refreshing already in progress. Queuing request.');
      _requestsQueue.add({'options': err.requestOptions, 'handler': handler, 'error': err});
      return;
    }

    _isRefreshing = true;
    if (kDebugMode) debugPrint(' [AuthInterceptor] Starting token refresh process...');

    try {
      final refreshResult = await TokenRefresher.refreshToken();

      if (refreshResult == RefreshResult.success) {
        final newToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
        if (kDebugMode) debugPrint(' Token refreshed. New token: ${newToken.substring(0, 10)}...');

  
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        try {
          final response = await dio.fetch(err.requestOptions);
          handler.resolve(response);
        } catch (e) {
          handler.next(e is DioException ? e : err);
        }

        for (var item in _requestsQueue) {
          final reqOptions = item['options'] as RequestOptions;
          final reqHandler = item['handler'] as ErrorInterceptorHandler;
          reqOptions.headers['Authorization'] = 'Bearer $newToken';
          try {
            final res = await dio.fetch(reqOptions);
            reqHandler.resolve(res);
          } catch (e) {
            reqHandler.next(e is DioException ? e : item['error']);
          }
        }
      } 
      else if (refreshResult == RefreshResult.banned) {
     
        if (kDebugMode) debugPrint(' [AuthInterceptor] Account banned. Forcing logout with security message.');
        await ForceLogoutHandler.forceLogout(
          message: 'تم حظر حسابك  بسبب نشاط غير آمن. الرجاء التواصل مع الدعم.',
          isSecurityBan: true,
        );
     
        for (var item in _requestsQueue) {
          final reqHandler = item['handler'] as ErrorInterceptorHandler;
          final reqError = item['error'] as DioException;
          reqHandler.next(reqError);
        }
        handler.next(err);
      }
      else {
        if (kDebugMode) debugPrint(' [AuthInterceptor] Token refresh failed (no ban). Logging out normally.');
        for (var item in _requestsQueue) {
          final reqHandler = item['handler'] as ErrorInterceptorHandler;
          final reqError = item['error'] as DioException;
          reqHandler.next(reqError);
        }
        await ForceLogoutHandler.forceLogout(); 
        handler.next(err);
      }
    } catch (e) {
      if (kDebugMode) debugPrint('💥 Unexpected error during refresh: $e');
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
    }
  }
}