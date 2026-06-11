import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/shared_screens/login/logic/logout_service.dart';
import 'package:graduation_progect/main.dart';

void showLogoutConfirmDialog(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  bool isLoading = false;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (dialogContext, setState) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: const Text(
                'تنبيه',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
              actions: [
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => Navigator.pop(dialogContext),
                  child: Text(
                    'إلغاء',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {

                          if (!ConnectivityHelper.isOnline) {
                            SnackbarHelper.showError(
                                message: 'لا يوجد اتصال بالإنترنت');
                            return;
                          }

                          setState(() => isLoading = true);


                          final success =
                              await LogoutService.execute(context);


                          if (!success && dialogContext.mounted) {
                            setState(() => isLoading = false);
                          }

                        },
                  child: isLoading
                      ? SizedBox(
                          height: 18.h,
                          width: 18.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'تسجيل خروج',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}



class SnackbarHelper {

  static void showError({required String message}) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


  static void showSuccess({required String message}) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}