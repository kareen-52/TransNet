import 'package:graduation_progect/features/shared_screens/login/logic/logout_service.dart';

class ForceLogoutHandler {
  ForceLogoutHandler._();

  /// يُستدعى من AuthInterceptor عند 401 غير قابل للتجديد أو 403 (banned/frozen).
  static Future<void> forceLogout({
    String? message,
    bool isSecurityBan = false,
  }) async {
    await LogoutService.forceLogout(
      message: message,
      isSecurityBan: isSecurityBan,
    );
  }
}