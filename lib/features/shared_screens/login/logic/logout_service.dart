import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/api_constants.dart';
import 'package:graduation_progect/core/networking/dio_factory.dart';

class LogoutService {
  static Future<bool> logout() async {
    try {
      final dio = await DioFactory.getDio();
      final response = await dio.get('${ApiConstants.apiBaseUrl}logout');

      if (response.statusCode == 200) {
        await SharedPrefHelper.removeSecuredData(SharedPrefKeys.userToken);
        await SharedPrefHelper.removeSecuredData(SharedPrefKeys.userRole);
        await SharedPrefHelper.removeSecuredData(SharedPrefKeys.refreshToken);
        await SharedPrefHelper.clearAllSecuredData();
        return true;
      }

      return false;
    } catch (error) {
      return false;
    }
  }
}
