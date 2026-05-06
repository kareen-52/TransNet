import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/notifications/notification_service.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/main.dart';

class ForceLogoutHandler {
  static Future<void> forceLogout() async {
    final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    if (token.isEmpty) return;

    await NotificationService.handleLogout();
    await SharedPrefHelper.clearAllSecuredData();
    await SharedPrefHelper.removeSecuredData(SharedPrefKeys.userRole);
    await SharedPrefHelper.removeSecuredData(SharedPrefKeys.userToken);

    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.security_rounded,
                color: Theme.of(context).colorScheme.onInverseSurface,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  "تم تسجيل الخروج لأسباب أمنية. يرجى مراجعة بريدك الإلكتروني للحصول على تفاصيل الدخول الجديدة.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        fontSize: 13.sp,
                      ),
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          duration: const Duration(seconds: 5),
        ),
      );
    }

    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }
}