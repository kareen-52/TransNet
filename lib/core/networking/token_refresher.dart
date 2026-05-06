import 'package:dio/dio.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/core/networking/dio_factory.dart';
import 'package:graduation_progect/features/shared_screens/login/logic/refresh_token_models.dart';

class TokenRefresher {
  static Future<bool> refreshToken() async {
    try {
      final refreshToken = await SharedPrefHelper.getSecuredString('refreshToken');
      if (refreshToken.isEmpty) return false;

      final refreshDio = Dio();
      final apiService = ApiService(refreshDio);

      final response = await apiService.refreshToken(
        RefreshTokenRequest(refreshToken: refreshToken),
      );

      if (response.accessToken != null) {
        await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, response.accessToken!);
        await SharedPrefHelper.setSecuredString('refreshToken', response.refreshToken ?? refreshToken);
        DioFactory.setTokenInHeaderAfterLogin(response.accessToken!);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> retryOriginalRequest(
    DioException e,
    ErrorInterceptorHandler handler,
  ) async {
    final newToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
    try {
      final dio = await DioFactory.getDio();
      final response = await dio.fetch(e.requestOptions);
      handler.resolve(response);
    } catch (err) {
      handler.next(e);
    }
  }
}