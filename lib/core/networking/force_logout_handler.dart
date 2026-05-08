
import 'package:graduation_progect/features/shared_screens/login/logic/logout_service.dart';
import 'package:graduation_progect/main.dart';

class ForceLogoutHandler {
  ForceLogoutHandler._();

  /// يُستدعى من AuthInterceptor عند 401 غير قابل للتجديد.
  /// لا يعتمد على GetIt — يستخدم الـ navigatorKey مباشرة من main.dart.
  static Future<void> forceLogout() async {
    await LogoutService.forceLogout(navigatorKey);
  }
}
