import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/driver/home/data/models/instant_order_model.dart';
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

    // 1. إشعار (طلب شحنة جديد) - يخص السائق
    if (title.contains('شحنة جديد')) {
      print("🚀 توجيه السائق إلى شاشته الرئيسية ليرى الطلبات الفورية");
      
      navContext.pushNamedAndRemoveUntil(Routes.driverHomeScreen, predicate: (route) => false);
    } 
    
    else if (title.contains('قبول')) {
      print("🚀 توجيه إلى شاشة التتبع للشحنة رقم: $shipmentId");
      // navContext.pushNamed(Routes.trackingScreen, arguments: shipmentId);
    }

    else if (title.contains('استلام') || title.contains('تأكيد')) {
      print("⭐ توجيه إلى شاشة التقييم للشحنة رقم: $shipmentId");
      // TODO: استبدل بالمسار الصحيح لشاشة التقييم
      // navContext.pushNamed(Routes.ratingScreen, arguments: shipmentId);
    }

    else if (title.contains('رفض')) {
      print("🔙 توجيه إلى الصفحة الرئيسية لإنشاء طلب جديد");
      // نرجعه للرئيسية لكي لا يبقى في شاشة فارغة
      // navContext.pushNamedAndRemoveUntil(Routes.clientHomeScreen, predicate: (route) => false);
    }
  }
}
