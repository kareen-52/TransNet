import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:graduation_progect/app_bloc_observer.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/map_tile_cache_service.dart';
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


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupGetIt();
  Bloc.observer = AppBlocObserver();

  await SharedPrefHelper.init();

  await Future.wait([
    Firebase.initializeApp(),
    HiveCacheService.init().then((_) => MapTileCacheService.init()),
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