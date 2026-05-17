import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/notifications/notification_route_helper.dart';
import 'package:graduation_progect/features/shared_screens/notifications/data/repo/notification_repo.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static const String _fcmTokenKey = 'fcm_device_token';

  static final StreamController<Map<String, dynamic>> instantOrderStreamController = StreamController<Map<String, dynamic>>.broadcast();

  static Future<void> init() async {

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _firebaseMessaging
        .requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
          criticalAlert: true,
        )
        .then((settings) {
          if (kDebugMode) {
            print('User permission status: ${settings.authorizationStatus}');
          }
        });

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: AndroidInitializationSettings('@drawable/ic_notification'),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          ),
        );

    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleNotificationClick(response.payload);
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      if (message.data.isNotEmpty) {
        instantOrderStreamController.sink.add(message.data);
      }

      if (notification != null) {
        _localNotifications.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@drawable/ic_notification',
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              enableVibration: true,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: jsonEncode(message.data),
        );
        try {
          getIt<NotificationCubit>().fetchUnreadCount();
        } catch (e) {
          print("⚠️ NotificationCubit is not registered yet: $e");
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(jsonEncode(message.data));
    });

    Future.microtask(() async {
      final RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationClick(jsonEncode(initialMessage.data));
      }

      handleDeviceTokenSync();
    });

    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      print("🔄 Token Refreshed: $newToken");
      await SharedPrefHelper.setData(_fcmTokenKey, newToken);
      String userAuthToken = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userToken,
      );
      if (userAuthToken.isNotEmpty) {
        getIt<NotificationRepo>().saveDeviceToken(newToken);
      }
    });
  }

  static Future<void> handleDeviceTokenSync({int retryCount = 0}) async {
    try {
      String? currentToken = await _firebaseMessaging.getToken();
      if (currentToken == null) return;

      String userAuthToken = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userToken,
      );

      if (userAuthToken.isEmpty) {
        print("ℹ️ Skipping sync: User not logged in yet.");
        return;
      }

      print("🚀 New Token Detected! Sending to backend...");
      await getIt<NotificationRepo>().saveDeviceToken(currentToken);

      await SharedPrefHelper.setData(_fcmTokenKey, currentToken);

      print("✅ Token is up to date. No need to send.");
    } catch (e) {
      print("❌ Failed to sync Device Token: $e");

      if (retryCount < 5) {
        print(
          "🔄 Retrying to fetch token in 5 seconds... (Attempt ${retryCount + 1})",
        );
        Future.delayed(const Duration(seconds: 5), () {
          handleDeviceTokenSync(retryCount: retryCount + 1);
        });
      }
    }
  }

  static void _handleNotificationClick(String? payload) {
    if (payload != null) {
      if (kDebugMode) print("👉 Notification Clicked with Payload: $payload");

      try {
        final Map<String, dynamic> data = jsonDecode(payload);

        final String title = data['title'] ?? '';
        final int shipmentId =
            int.tryParse(data['shipment_id']?.toString() ?? '0') ?? 0;

        NotificationRouteHelper.handleNotificationAction(
          title: title,
          shipmentId: shipmentId,
          fullData: data,
        );
      } catch (e) {
        if (kDebugMode) print("❌ Error routing from notification: $e");
      }
    }
  }

  static Future<void> handleLogout() async {
    try {
      await _firebaseMessaging.deleteToken();

      await SharedPrefHelper.removeData(_fcmTokenKey);

      print("🚪 Firebase Token Deleted & Synced for Logout!");
    } catch (e) {
      print("❌ Failed to handle logout token deletion: $e");
    }
  }

  static void dispose() {
    instantOrderStreamController.close();
  }
}



// import 'dart:async';
// import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:graduation_progect/core/di/dependency_injection.dart';
// import 'package:graduation_progect/core/helpers/constants.dart';
// import 'package:graduation_progect/core/helpers/sharedpreference.dart';
// import 'package:graduation_progect/core/notifications/notification_route_helper.dart';
// import 'package:graduation_progect/features/driver/active_shipments_driver/logic/active_driver_shipments_cubit.dart';
// import 'package:graduation_progect/features/shared_screens/notifications/data/repo/notification_repo.dart';
// import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';
// import 'package:graduation_progect/features/user/active_orders/logic/active_orders_cubit.dart';
// import 'package:graduation_progect/features/user/home_screen/logic/home_cubit.dart';

// // ✅ هاد الـ background handler لازم يبقى هون برا الكلاس
// // لأن Firebase بيستدعيه في isolate منفصل
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // ✅ هون Firebase.initializeApp() ضروري لأن هاد isolate منفصل
//   // وما في علاقة بالـ main() اللي هيأنا فيه Firebase
//   await Firebase.initializeApp();
//   if (kDebugMode) {
//     print("📩 Background message: ${message.messageId}");
//   }
// }

// class NotificationService {
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin _localNotifications =
//       FlutterLocalNotificationsPlugin();
//   static const String _fcmTokenKey = 'fcm_device_token';

//   static final StreamController<Map<String, dynamic>>
//   instantOrderStreamController =
//       StreamController<Map<String, dynamic>>.broadcast();

//   static Future<void> init() async {
//     // ✅ [1] حذفنا: await Firebase.initializeApp();
//     // لأن Firebase اتهيّأ في main() قبل استدعاء هاد الـ function
//     // استدعاؤه مرتين بيسبب exception أو تأخير

//     // ✅ [2] سجّل الـ background handler أول شي
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     // ✅ [3] اطلب الإذن بدون await لأنك ما محتاج تنتظر رد المستخدم
//     // هاد بيوفر وقت ثمين في بداية التطبيق
//     _firebaseMessaging
//         .requestPermission(
//           alert: true,
//           badge: true,
//           sound: true,
//           provisional: false,
//           criticalAlert: true,
//         )
//         .then((settings) {
//           if (kDebugMode) {
//             print('🔔 Permission status: ${settings.authorizationStatus}');
//           }
//         });

//     // ✅ [4] هاد الـ channel تمام، بس حطيناه كـ static لأننا محتاجينه بأكتر من مكان
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       description: 'This channel is used for important notifications.',
//       importance: Importance.max,
//       playSound: true,
//       enableVibration: true,
//     );

//     // ✅ [5] بدون await لأن createNotificationChannel مش ضرورية تنتهي قبل المتابعة
//     _localNotifications
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(channel);

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//           android: AndroidInitializationSettings('@drawable/ic_notification'),
//           iOS: DarwinInitializationSettings(
//             requestAlertPermission: true,
//             requestBadgePermission: true,
//             requestSoundPermission: true,
//           ),
//         );

//     // ✅ [6] هاد الـ await ضروري لأننا محتاجين الـ local notifications
//     // تكون جاهزة قبل ما نبدأ نستقبل messages
//     await _localNotifications.initialize(
//       settings: initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         _handleNotificationClick(response.payload);
//       },
//     );

//     // ✅ [7] استمع للمسجات وهيّأ باقي الـ listeners
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       final data = message.data;
//       final String title = notification?.title ?? data['title'] ?? '';


//       if (data.isNotEmpty) {
//         instantOrderStreamController.sink.add(message.data);
//       }

//       // ── قبول الطلب → refresh فوري للطلبات النشطة ──────────────────────
//       if (title == 'قبول الطلب') {
//         try {
//           getIt<ActiveOrdersCubit>().silentRefresh();
//           getIt<ActiveDriverShipmentsCubit>().silentRefresh();
//         } catch (e) {
//           if (kDebugMode) print("⚠️ ActiveOrdersCubit not ready: $e");
//         }
//       }


//       if (notification != null) {
//         _localNotifications.show(
//           id: notification.hashCode,
//           title: notification.title,
//           body: notification.body,
//           notificationDetails: NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               channelDescription: channel.description,
//               icon: '@drawable/ic_notification',
//               importance: Importance.max,
//               priority: Priority.high,
//               playSound: true,
//               enableVibration: true,
//             ),
//             iOS: const DarwinNotificationDetails(
//               presentAlert: true,
//               presentBadge: true,
//               presentSound: true,
//             ),
//           ),
//           payload: jsonEncode(message.data),
//         );

//         try {
//           getIt<NotificationCubit>().fetchUnreadCount();
//         } catch (e) {
//           if (kDebugMode) {
//             print("⚠️ NotificationCubit not registered yet: $e");
//           }
//         }


//         // ── تحديث حالة الهوم عند رفض أو قبول الطلب ──────────────────────
//         try {
//           if (title.contains('رفض') || title.contains('قبول')) {
//             getIt<HomeCubit>().checkActiveShipment();
//           }
//         } catch (e) {
//           if (kDebugMode) {
//             print("⚠️ HomeCubit not registered yet: $e");
//           }
//         }
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _handleNotificationClick(jsonEncode(message.data));
//     });


//     // تأخير 2 ثانية لضمان حفظ access_token قبل المزامنة
//     Future.delayed(const Duration(seconds: 2), () async {
//       final initial = await _firebaseMessaging.getInitialMessage();
//       if (initial != null) _handleNotificationClick(jsonEncode(initial.data));
//       handleDeviceTokenSync();
//     });


//     // ✅ [8] microtask تمام - بتشتغل بعد ما يكتمل الـ frame الأول
//     // Future.microtask(() async {
//     //   final RemoteMessage? initialMessage = await _firebaseMessaging
//     //       .getInitialMessage();
//     //   if (initialMessage != null) {
//     //     _handleNotificationClick(jsonEncode(initialMessage.data));
//     //   }
//     //   handleDeviceTokenSync();
//     // });

//     _firebaseMessaging.onTokenRefresh.listen((newToken) async {
//       if (kDebugMode) print("🔄 Token Refreshed: $newToken");
      
//       await SharedPrefHelper.setSecuredString(_fcmTokenKey, newToken);

//       final String userAuthToken = await SharedPrefHelper.getSecuredString(
//         SharedPrefKeys.userToken,
//       );
//       if (userAuthToken.isNotEmpty) {
//         getIt<NotificationRepo>().saveDeviceToken(newToken);
//       }
//     });
//   }

//   static Future<void> handleDeviceTokenSync({int retryCount = 0}) async {
//     try {
//       final String? currentToken = await _firebaseMessaging.getToken();
//       if (currentToken == null) return;

//       final String userAuthToken = await SharedPrefHelper.getSecuredString(
//         SharedPrefKeys.userToken,
//       );

//       if (userAuthToken.isEmpty) {
//         if (kDebugMode) print("ℹ️ Skipping sync: User not logged in yet.");
//         return;
//       }

//       final String? savedToken = await _getStoredToken();
//       if (savedToken == currentToken) {
//         if (kDebugMode) print("ℹ️ Token unchanged — skipping sync.");
//         return; // ✅ تحسين: لا ترسل للسيرفر إذا لم يتغير التوكن
//       }

//       if (kDebugMode) print("🚀 Sending token to backend...");

//       await getIt<NotificationRepo>().saveDeviceToken(currentToken);
//       await SharedPrefHelper.setSecuredString(_fcmTokenKey, currentToken);

//       if (kDebugMode) print("✅ Token synced successfully.");
//     }
    
//     catch (e) {
//       if (kDebugMode) print("❌ Failed to sync Device Token: $e");

//       // ✅ [9] الـ retry logic تمام، بس خلّينا الـ print بس في debug mode
//       if (retryCount < 5) {
//         if (kDebugMode) {
//           print("🔄 Retrying in 5 seconds... (Attempt ${retryCount + 1})");
//         }
//         Future.delayed(const Duration(seconds: 5), () {
//           handleDeviceTokenSync(retryCount: retryCount + 1);
//         });
//       }
//     }
//   }



//   static void _handleNotificationClick(String? payload) {
//     if (payload == null) return;

//     if (kDebugMode) print("👉 Notification clicked: $payload");

//     try {
//       final Map<String, dynamic> data = jsonDecode(payload);
//       final String title = data['title'] ?? '';
//       final int shipmentId =
//           int.tryParse(data['shipment_id']?.toString() ?? '0') ?? 0;

//       NotificationRouteHelper.handleNotificationAction(
//         title: title,
//         shipmentId: shipmentId,
//         fullData: data,
//       );
//     } catch (e) {
//       if (kDebugMode) print("❌ Error routing from notification: $e");
//     }
//   }

  

//   static Future<void> handleLogout() async {
//     try {
//       await _firebaseMessaging.deleteToken();
//       await SharedPrefHelper.removeSecuredData(_fcmTokenKey);
//       if (kDebugMode) print("🚪 Firebase Token Deleted for Logout!");
//     } catch (e) {
//       if (kDebugMode) print("❌ Failed to handle logout token deletion: $e");
//     }
//   }


//   // ── Helper: قراءة التوكن المخزَّن ─────────────────────────────────────────
//   static Future<String?> _getStoredToken() async {
//     final stored = await SharedPrefHelper.getSecuredString(_fcmTokenKey);
//     return stored.isEmpty ? null : stored;
//   }

//   static void dispose() {
//     instantOrderStreamController.close();
//   }
// }
