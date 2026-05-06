import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/routing/routes.dart';
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
        builder: (context, setState) {
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
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 12.w,
                    //   vertical: 8.h,
                    // ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() => isLoading = true);

                          final success = await LogoutService.logout();

                          if (!dialogContext.mounted) return;

                          if (success) {
                            Navigator.pop(dialogContext);

                            SnackBarHelper.showSuccess(
                              context,
                              'تم تسجيل الخروج بنجاح',
                            );

                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text('تم تسجيل الخروج بنجاح'),
                            //     backgroundColor: Colors.green,
                            //   ),
                            // );

                            navigatorKey.currentState?.pushNamedAndRemoveUntil(
                              Routes.login,
                              (route) => false,
                            );
                          } else {
                            setState(() => isLoading = false);

                            SnackBarHelper.showError(
                              context,
                              'فشل تسجيل الخروج',
                            );

                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text('فشل تسجيل الخروج'),
                            //     backgroundColor: Colors.red,
                            //   ),
                            // );
                          }
                        },
                  child: isLoading
                      ? SizedBox(
                          height: 18.h,
                          width: 18.h,
                          child: const CircularProgressIndicator(
                            // color: Colors.white,
                            strokeWidth: 2,
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
