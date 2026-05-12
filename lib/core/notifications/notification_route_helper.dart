import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/features/user/active_orders/logic/active_orders_cubit.dart';
import 'package:graduation_progect/features/user/home_screen/logic/home_cubit.dart';
import 'package:graduation_progect/main.dart';

class NotificationRouteHelper {
  static void handleNotificationAction({
    required String title,
    required int shipmentId,
    required Map<String, dynamic> fullData,
    BuildContext? context,
  }) {
    final BuildContext? navContext = context ?? navigatorKey.currentContext;
    if (navContext == null) return;
    if (kDebugMode) print("🔔 Notification action: title='$title' id=$shipmentId");


    void refreshHome() {
      try {
        getIt<HomeCubit>().checkActiveShipment();
      } catch (e) {
        if (kDebugMode) print("⚠️ HomeCubit not ready: $e");
      }
    }

    void refreshActiveOrders() {
      try {
        getIt<ActiveOrdersCubit>().silentRefresh();
      } catch (e) {
        if (kDebugMode) print("⚠️ ActiveOrdersCubit not ready: $e");
      }
    }



    // 1. إشعار (طلب شحنة جديد) - يخص السائق
    if (title.contains('شحنة جديد')) {
      if (kDebugMode) print("🚛 توجيه السائق إلى الهوم");
      navContext.pushNamedAndRemoveUntil(
        Routes.driverHomeScreen,
        predicate: (route) => false,
      );
    }


    else if (title == 'رفض الطلب') {
      if (kDebugMode) print("❌ الطلب رُفض — تحديث الهوم");
      refreshHome();
    }
    

    else if (title == 'قبول الطلب') {
      if (kDebugMode) print("✅ الطلب قُبل — refresh الطلبات النشطة");
      refreshHome();
      refreshActiveOrders();
      // TODO: لما تعمل شاشة التتبع فعّل السطر هاد:
      // navContext.pushNamed(Routes.trackingScreen, arguments: shipmentId);
    }

    
    else if (title.contains('استلام') || title.contains('تأكيد')) {
      if (kDebugMode) print("⭐ تم التسليم — توجيه للتقييم id=$shipmentId");
      refreshHome();
      refreshActiveOrders();
      // TODO: شاشة التقييم
      // navContext.pushNamed(Routes.ratingScreen, arguments: shipmentId);
    }

   
  }
}
