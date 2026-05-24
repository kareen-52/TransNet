import 'package:graduation_progect/features/shared_screens/login/logic/logout_service.dart';

class ForceLogoutHandler {
  ForceLogoutHandler._();


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