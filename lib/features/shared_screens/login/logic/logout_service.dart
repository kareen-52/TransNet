import 'package:flutter/material.dart';
import 'package:graduation_progect/connectivity_helper.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/api_constants.dart';
import 'package:graduation_progect/core/networking/dio_factory.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/logout_dialog.dart';
import 'package:graduation_progect/hive_cache_service.dart';
import 'package:graduation_progect/main.dart';

class LogoutService {
  LogoutService._();

  // ─── المسح المحلي دائماً — بغض النظر عن الـ API ──────────────────────────
  static Future<void> _clearLocalData() async {
    await Future.wait([
      HiveCacheService.clearAll(),
      SharedPrefHelper.clearAllSecuredData(),
      SharedPrefHelper.clearAllData(),
    ]);
 
  }

/// يُستدعى من زر المستخدم.
/// يُحاول استدعاء API الخروج، وفقط عند الـ 2xx يعمل مسح محلي ويُوجّه للـ login.
/// يُرجع `true` إذا تم الخروج بنجاح، و `false` إذا فشل.
static Future<bool> execute(BuildContext context) async {
  // تحقق من الاتصال أولاً
  if (!ConnectivityHelper.isOnline) {
    SnackbarHelper.showError(message: 'لا يوجد اتصال بالإنترنت');
    return false;
  }

  // استدعاء API
  try {
    final dio = DioFactory.getDio();
    final response = await dio
        .get('${ApiConstants.apiBaseUrl}${ApiConstants.logout}')
        .timeout(const Duration(seconds: 5));

    // تحقق من كود الحالة (أي 2xx)
    if (response.statusCode == null || response.statusCode! < 200 || response.statusCode! >= 300) {
      SnackbarHelper.showError(message: 'فشل تسجيل الخروج من السيرفر');
      return false;
    }
  } catch (_) {
    SnackbarHelper.showError(message: 'حدث خطأ أثناء الاتصال بالسيرفر');
    return false;
  }

  // نجاح API ← مسح البيانات المحلية
  await _clearLocalData();

  SnackbarHelper.showSuccess(message: 'تم تسجيل الخروج بنجاح');

  // توجيه إلى شاشة الدخول
  if (navigatorKey.currentState != null) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }

  return true;
}
  // ─── Force Logout (انتهاء الـ token — بدون context) ─────────────────────
  /// يُستدعى من ForceLogoutHandler عند 401 غير قابل للتجديد.
  static Future<void> forceLogout(GlobalKey<NavigatorState> navKey) async {
    await _clearLocalData();

    final context = navKey.currentContext;
    if (context == null || !context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.login,
      (route) => false,
    );
  }
}
