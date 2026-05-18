import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/logic/active_driver_shipments_cubit.dart';
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

    void refreshClientActiveOrders() {
      try {
        getIt<ActiveOrdersCubit>().silentRefresh();
      } catch (e) {
        if (kDebugMode) print("⚠️ ActiveOrdersCubit not ready: $e");
      }
    }

    void refreshDriverActiveShipments() {
      try {
        getIt<ActiveDriverShipmentsCubit>().silentRefresh();
      } catch (e) {
        if (kDebugMode) print("⚠️ ActiveDriverShipmentsCubit not ready: $e");
      }
    }



    if (title.contains('شحنة جديد')) {
      if (kDebugMode) print("🚛 توجيه السائق إلى الهوم");
      navContext.pushNamedAndRemoveUntil(
        Routes.driverHomeScreen,
        predicate: (route) => false,
      );
    }


    else if (title.contains('رفض')) {
      if (kDebugMode) print("❌ الطلب رُفض — تحديث الهوم");
      refreshHome();
    }
    

    else if (title.contains('قبول')) {
      if (kDebugMode) print("✅ الطلب قُبل — refresh الطلبات النشطة");
      refreshHome();
      refreshClientActiveOrders();
      refreshDriverActiveShipments();
    }

    
    else if (title.contains('استلام') || title.contains('تأكيد')) {
      if (kDebugMode) print("⭐ تم التسليم — توجيه للتقييم id=$shipmentId");
      refreshHome();
      refreshClientActiveOrders();
      refreshDriverActiveShipments();
      
    }

   
  }
}
