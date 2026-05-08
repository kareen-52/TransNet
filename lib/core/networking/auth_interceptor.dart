import 'dart:async';
import 'package:dio/dio.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/dio_factory.dart';
import 'package:graduation_progect/core/networking/force_logout_handler.dart';
import 'package:graduation_progect/core/networking/token_refresher.dart';

/// Fixed AuthInterceptor — eliminates the deadlock caused by:
///   1. `static bool _isRefreshing` shared across all queued requests
///   2. `await DioFactory.getDio()` called on a non-async method
///   3. Requests queued during refresh never being resolved/rejected
class AuthInterceptor extends QueuedInterceptorsWrapper {
  // Completer-based lock: waiting requests subscribe to this future
  // and are resolved once the token refresh completes.
  static Completer<bool>? _refreshCompleter;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Only handle 401 — all other errors pass through immediately
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    // ── Token refresh ──────────────────────────────────────────────────────

    if (_refreshCompleter == null) {
      // This request is first — it owns the refresh
      _refreshCompleter = Completer<bool>();

      final refreshed = await TokenRefresher.refreshToken();
      _refreshCompleter!.complete(refreshed);
      _refreshCompleter = null; // reset for next time

      if (!refreshed) {
        await ForceLogoutHandler.forceLogout();
        handler.reject(err);
        return;
      }
    } else {
      // Another request is already refreshing — wait for it
      final refreshed = await _refreshCompleter!.future;
      if (!refreshed) {
        handler.reject(err);
        return;
      }
    }

    // ── Retry original request with new token ──────────────────────────────
    try {
      final newToken = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userToken,
      );
      err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

      // Use the existing singleton Dio — no await needed
      final dio = DioFactory.getDio();
      final response = await dio.fetch(err.requestOptions);
      handler.resolve(response);
    } catch (retryError) {
      handler.next(err);
    }
  }
}