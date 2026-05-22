import 'package:flutter/material.dart';
import 'package:graduation_progect/connectivity_helper.dart';
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
  static Future<bool> execute(BuildContext context) async {
    if (!ConnectivityHelper.isOnline) {
      SnackbarHelper.showError(message: 'لا يوجد اتصال بالإنترنت');
      return false;
    }

    try {
      final dio = DioFactory.getDio();
      final response = await dio
          .get('${ApiConstants.apiBaseUrl}${ApiConstants.logout}')
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == null || response.statusCode! < 200 || response.statusCode! >= 300) {
        SnackbarHelper.showError(message: 'فشل تسجيل الخروج من السيرفر');
        return false;
      }
    } catch (_) {
      SnackbarHelper.showError(message: 'حدث خطأ أثناء الاتصال بالسيرفر');
      return false;
    }

    await _clearLocalData();
    SnackbarHelper.showSuccess(message: 'تم تسجيل الخروج بنجاح');

    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        Routes.login,
        (route) => false,
      );
    }
    return true;
  }

  // ─── Force Logout (انتهاء الـ token أو حظر) ──────────────────────────────
  /// يُستدعى من ForceLogoutHandler عند 401 غير قابل للتجديد أو 403 محظور.
  /// يعرض ديالوج برسالة أمنية إذا وُجدت، ثم يمسح البيانات ويوجّه للدخول.
  static Future<void> forceLogout({
    String? message,
    bool isSecurityBan = false,
  }) async {
    // إذا كان هناك رسالة، نحاول عرضها عبر navigatorKey قبل مسح البيانات
    if (message != null && message.isNotEmpty) {
      final context = navigatorKey.currentContext;
      if (context != null) {
        // نستخدم addPostFrameCallback لضمان أن الـ context جاهز
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => AlertDialog(
            title: Text(isSecurityBan ? 'حظر الحساب' : 'انتهاء الجلسة'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(dialogContext).pop();
                  await _performLogout();
                },
                child: Text('حسناً'),
              ),
            ],
          ),
        );
        return;
      }
    }
    // إذا لم توجد رسالة أو لم يتوفر context، نقوم بالخروج مباشرة
    await _performLogout();
  }

  static Future<void> _performLogout() async {
    await _clearLocalData();
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        Routes.login,
        (route) => false,
      );
    }
  }
}