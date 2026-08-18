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
import 'package:graduation_progect/features/driver/active_shipments_driver/logic/active_driver_shipments_cubit.dart';
import 'package:graduation_progect/features/shared_screens/notifications/data/repo/notification_repo.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';
import 'package:graduation_progect/features/user/active_orders/logic/active_orders_cubit.dart';
import 'package:graduation_progect/features/user/home_screen/logic/home_cubit.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const String _fcmTokenKey = 'fcm_device_token';
  static Future<String?> _getStoredToken() async {
    final stored = await SharedPrefHelper.getSecuredString(_fcmTokenKey);

    return stored.isEmpty ? null : stored;
  }

  static final StreamController<Map<String, dynamic>>
  instantOrderStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

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

      final data = message.data;
      final String title = notification?.title ?? data['title'] ?? '';

      final bool isGenuineInstantOrder = title.contains('شحنة جديد');

      if (data.isNotEmpty && isGenuineInstantOrder) {
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


        if (title.contains('قبول')) {
          try {
            getIt<HomeCubit>().checkActiveShipment();
            getIt<ActiveOrdersCubit>().silentRefresh();
            getIt<ActiveDriverShipmentsCubit>().silentRefresh();
          } catch (e) {
            if (kDebugMode) print("⚠️ ActiveOrdersCubit not ready: $e");
          }
        }

        try {
          if (title.contains('استلام') || title.contains('تم تأكيد')) {
            getIt<ActiveDriverShipmentsCubit>().silentRefresh();
            getIt<ActiveOrdersCubit>().silentRefresh();
          }
        } catch (e) {
          if (kDebugMode) print("⚠️ not ready: $e");
        }


        try {
          if (title.contains('رفض')) {
            getIt<HomeCubit>().checkActiveShipment();
          }
        } catch (e) {
          if (kDebugMode) {
            print("⚠️ HomeCubit not registered yet: $e");
          }
        }

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
      final RemoteMessage? initialMessage = await _firebaseMessaging
          .getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationClick(jsonEncode(initialMessage.data));
      }

      handleDeviceTokenSync();
    });

    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      print("🔄 Token Refreshed: $newToken");
      await SharedPrefHelper.setSecuredString(_fcmTokenKey, newToken);
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
      final currentToken = await _firebaseMessaging.getToken();

      if (currentToken == null) return;

      final authToken = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userToken,
      );

      if (authToken.isEmpty) {
        if (kDebugMode) {
          print("ℹ️ User not logged in.");
        }

        return;
      }

      final storedToken = await _getStoredToken();

      if (storedToken == currentToken) {
        if (kDebugMode) {
          print("ℹ️ Token unchanged.");
        }

        return;
      }

      if (kDebugMode) {
        print("🚀 Syncing new token...");
      }

      await getIt<NotificationRepo>().saveDeviceToken(currentToken);

      await SharedPrefHelper.setSecuredString(_fcmTokenKey, currentToken);
    } catch (e) {
      if (kDebugMode) {
        print("❌ Token sync failed: $e");
      }

      if (retryCount < 5) {
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
  final String body = data['body'] ?? '';

  int shipmentId = 0;
  int postId = 0;

  if (data.containsKey('notification')) {
    try {
      final dynamic rawNotif = data['notification'];
      final Map<String, dynamic> notifData = rawNotif is String
          ? jsonDecode(rawNotif) as Map<String, dynamic>
          : Map<String, dynamic>.from(rawNotif as Map);

      shipmentId =
          int.tryParse(notifData['id']?.toString() ?? '0') ?? 0;
      postId =
          int.tryParse(notifData['post_id']?.toString() ?? '0') ?? 0;
    } catch (e) {
      if (kDebugMode) print("❌ Error parsing nested notification data: $e");
    }
  } else {
    shipmentId = int.tryParse(data['id']?.toString() ?? '0') ?? 0;
    postId = int.tryParse(data['post_id']?.toString() ?? '0') ?? 0;
  }

  if (kDebugMode) {
    print("🎯 Extracted IDs -> Shipment: $shipmentId, Post: $postId");
  }

        NotificationRouteHelper.handleNotificationAction(
          title: title,
          body: body,
          shipmentId: shipmentId,
          fullData: data,
          postId: postId,
        );
      } catch (e) {
        if (kDebugMode) print("❌ Error routing from notification: $e");
      }
    }
  }

  static Future<void> handleLogout() async {
    try {
      await _firebaseMessaging.deleteToken();

      await SharedPrefHelper.removeSecuredData(_fcmTokenKey);

      print("🚪 Firebase Token Deleted & Synced for Logout!");
    } catch (e) {
      print("❌ Failed to handle logout token deletion: $e");
    }
  }

  static void dispose() {
    instantOrderStreamController.close();
  }
}