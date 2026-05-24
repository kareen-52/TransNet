// import 'package:device_preview/device_preview.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:graduation_progect/core/di/dependency_injection.dart';
// import 'package:graduation_progect/core/helpers/constants.dart';
// import 'package:graduation_progect/core/helpers/sharedpreference.dart';
// import 'package:graduation_progect/core/notifications/notification_service.dart';
// import 'package:graduation_progect/core/routing/app_router.dart';
// import 'package:graduation_progect/core/routing/routes.dart';
// import 'package:graduation_progect/core/theming/theme_cash_helper.dart';
// import 'package:graduation_progect/graduation_project.dart';
// // import 'package:overlay_support/overlay_support.dart';

// String initialAppRoute = Routes.onboardingScreens;
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// void main() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

//   // await Future.wait([
//   //   Firebase.initializeApp(),
//   //   SharedPrefHelper.init(),
//   //   setupGetIt(),
//   // ]);
//   final results = await Future.wait([
//     Firebase.initializeApp(),
//     SharedPrefHelper.init(),
//     ThemeCacheHelper.getTheme(),
//     setupGetIt(),
//     checkIfLoggedInUser(),
//   ]);
//   // await Firebase.initializeApp();
//   // await SharedPrefHelper.init();

//   // final results = await Future.wait([
//   //   ThemeCacheHelper.getTheme(),
//   //   checkIfLoggedInUser(),
//   // ]);

//   final ThemeMode savedTheme = results[2] as ThemeMode;

//   // await setupGetIt();

//   // final ThemeMode savedTheme = await ThemeCacheHelper.getTheme();
//   // await checkIfLoggedInUser();

//   FlutterNativeSplash.remove();

//   runApp(
//     // DevicePreview(
//     //   enabled: !kReleaseMode,
//     //   builder: (_) =>
//     MyGraduationProject(
//       appRouter: AppRouter(),
//       initialTheme: savedTheme,
//       startRoute: initialAppRoute,
//     ),
//     // ),
//   );

//   NotificationService.init().catchError((e) {
//     print("❌ خطأ أثناء تهيئة الإشعارات في الخلفية: $e");
//   });
// }

// Future<void> checkIfLoggedInUser() async {
//   final token = await SharedPrefHelper.getSecuredString(
//     SharedPrefKeys.userToken,
//   );
//   final role = SharedPrefHelper.getString(SharedPrefKeys.userRole);
//   final isFirstLogin = SharedPrefHelper.getBool(SharedPrefKeys.isFirstLogin);

//   if (token.isNotEmpty) {
//     if (isFirstLogin == true) {
//       initialAppRoute = Routes.login;
//     } else {
//       print(role);

//       initialAppRoute = (role == 'driver')
//           ? Routes.driverHomeScreen
//           : Routes.clientHomeScreen;
//     }
//   } else {
//     initialAppRoute = Routes.onboardingScreens;
//   }
// }

import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:graduation_progect/app_bloc_observer.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/notifications/notification_service.dart';
import 'package:graduation_progect/core/routing/app_router.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/theme_cash_helper.dart';
import 'package:graduation_progect/graduation_project.dart';
import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/hive_cache_service.dart';

String _initialRoute = Routes.onboardingScreens;
ThemeMode _savedTheme = ThemeMode.system;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  setupGetIt();
  Bloc.observer = AppBlocObserver();

  await Future.wait([
    Firebase.initializeApp(),
    SharedPrefHelper.init(),
    HiveCacheService.init(),
    ConnectivityHelper.init(),  
    ThemeCacheHelper.getTheme().then((t) => _savedTheme = t),
    _determineInitialRoute(),
  ]);

  FlutterNativeSplash.remove();

  unawaited(
    NotificationService.init().catchError((e) {
      if (kDebugMode) {
        debugPrint(' خطأ في الإشعارات: $e');
      }
    }),
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (_) => MyGraduationProject(
        appRouter: AppRouter(),
        initialTheme: _savedTheme,
        startRoute: _initialRoute,
      ),
    ),
  );
}

Future<void> _determineInitialRoute() async {
  final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  final role = SharedPrefHelper.getString(SharedPrefKeys.userRole);
  final isFirstLogin = SharedPrefHelper.getBool(SharedPrefKeys.isFirstLogin);

  if (token.isNotEmpty) {
    if (isFirstLogin == true) {
      _initialRoute = Routes.login;
    } else {
      _initialRoute = (role == 'driver')
          ? Routes.driverHomeScreen
          : Routes.clientHomeScreen;
    }
  } else {
    _initialRoute = Routes.onboardingScreens;
  }
}