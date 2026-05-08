import 'package:flutter/material.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/routing/routes.dart';
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

    void updateHomeQuietly() {
      try {

        getIt<HomeCubit>().checkActiveShipment();
     
      } catch (e) {
        print("⚠️ HomeCubit not registered yet");
      }
    }



    // 1. إشعار (طلب شحنة جديد) - يخص السائق
    if (title.contains('شحنة جديد')) {
      print("🚀 توجيه السائق إلى شاشته الرئيسية ليرى الطلبات الفورية");
      
      navContext.pushNamedAndRemoveUntil(Routes.driverHomeScreen, predicate: (route) => false);
    } 


    else if (title.contains('رفض')) {
          updateHomeQuietly();
      // navContext.pushNamed(Routes.availableDriversScreen, );
      // navContext.pushNamedAndRemoveUntil(Routes.clientHomeScreen, predicate: (route) => false);
    }
    
    else if (title.contains('قبول')) {
      print("🚀 توجيه إلى شاشة التتبع للشحنة رقم: $shipmentId");
      updateHomeQuietly();
      // navContext.pushNamed(Routes.trackingScreen, arguments: shipmentId);
    }

    else if (title.contains('استلام') || title.contains('تأكيد')) {
      print("⭐ توجيه إلى شاشة التقييم للشحنة رقم: $shipmentId");
      updateHomeQuietly();
      // TODO: استبدل بالمسار الصحيح لشاشة التقييم
      // navContext.pushNamed(Routes.ratingScreen, arguments: shipmentId);
    }

   
  }
}
