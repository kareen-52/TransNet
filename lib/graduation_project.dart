import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/routing/app_router.dart';
import 'package:graduation_progect/core/theming/theme_cubit.dart';
import 'package:graduation_progect/core/theming/app_theme.dart';
import 'package:graduation_progect/main.dart';

class MyGraduationProject extends StatelessWidget {
  final AppRouter appRouter;
  final ThemeMode initialTheme;
  final String startRoute;
  const MyGraduationProject({
    super.key,
    required this.appRouter,
    required this.initialTheme,
    required this.startRoute,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(initialTheme),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: false,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                title: 'TransNet',
                debugShowCheckedModeBanner: false,

                locale: const Locale('ar'),

                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],

                supportedLocales: const [Locale('ar')],
                themeMode: themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                onGenerateRoute: appRouter.generateRoute,
                initialRoute: startRoute,

                //Routes.onboardingScreens,
              );
            },
          );
        },
      ),
    );
  }
}
