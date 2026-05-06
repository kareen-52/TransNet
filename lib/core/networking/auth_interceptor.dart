import 'package:dio/dio.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/dio_factory.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/networking/force_logout_handler.dart';
import 'package:graduation_progect/core/networking/token_refresher.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  static bool _isRefreshing = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (!_isRefreshing) {
        _isRefreshing = true;
        bool isTokenRefreshed = await TokenRefresher.refreshToken();
        _isRefreshing = false;

        if (isTokenRefreshed) {
          final newToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

          final dio = await DioFactory.getDio();
          final response = await dio.fetch(err.requestOptions);
          handler.resolve(response);
        } else {
          await ForceLogoutHandler.forceLogout();
          handler.reject(err);
        }
      } else {
        await TokenRefresher.retryOriginalRequest(err, handler);
      }
    } else {
      handler.next(err);
    }
  }
}