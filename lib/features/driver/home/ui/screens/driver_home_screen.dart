import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/responsive/responsive_layout.dart';
import 'package:graduation_progect/features/driver/apply_to_post/ui/apply_post_bottom_sheet.dart';
import 'package:graduation_progect/features/driver/home/logic/home_driver_cubit.dart';
import 'package:graduation_progect/features/driver/home/ui/screens/mobile_body.dart';
import 'package:graduation_progect/features/driver/home/ui/screens/tablet_body.dart';
import 'package:graduation_progect/features/driver/instant_orders/logic/instant_orders_cubit.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/driver/setLocation/logic/driver_location_cubit.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});


  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  late Future<int> _driverIdFuture;

  @override
  void initState() {
    super.initState();
    _driverIdFuture = _getDriverId();
    //  getIt<DriverNavCubit>().changeTab(0);
  }

  Future<int> _getDriverId() async {
    return SharedPrefHelper.getInt(SharedPrefKeys.driverId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<int>(
      future: _driverIdFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            extendBody: true,
            body: Center(
              child: CircularProgressIndicator(color: theme.colorScheme.primary),
            ),
          );
        }

        final driverId = snapshot.data ?? 0;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => getIt<DriverHomeCubit>()..loadAllData(driverId),
            ),
            BlocProvider(create: (_) => getIt<DriverLocationCubit>()),
            BlocProvider(create: (_) => getIt<ProfileCubit>()),
            BlocProvider.value(
              value: getIt<NotificationCubit>()..fetchUnreadCount(),
            ),
            BlocProvider.value(value: getIt<InstantOrdersCubit>()),
          ],
          child: Container(
            color: theme.scaffoldBackgroundColor,
            child: const SafeArea(
              top: false,
              child: ClipRRect(
                child: ResponsiveLayout(
                  mobile: MobileBody(),
                  tablet: TabletBody(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}