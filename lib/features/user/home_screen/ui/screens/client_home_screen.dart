import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/responsive/responsive_layout.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';
import 'package:graduation_progect/features/user/active_orders/logic/active_orders_cubit.dart';
import 'package:graduation_progect/features/user/home_screen/logic/home_cubit.dart';
import 'package:graduation_progect/features/user/home_screen/logic/home_state.dart';
import 'package:graduation_progect/features/user/vehicle_types/logic/vehicle_types_cubit.dart';
import 'package:graduation_progect/features/user/home_screen/ui/screens/mobile_body.dart';
import 'package:graduation_progect/features/user/home_screen/ui/screens/tablet_body.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  bool _isFirstCheck = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<HomeCubit>()..checkActiveShipment()),
        BlocProvider.value(
          value: getIt<ActiveOrdersCubit>()..fetchActiveOrders(),
        ),
        BlocProvider(
          create: (context) => getIt<VehicleTypesCubit>()..fetchVehicleTypes(),
        ),
        BlocProvider.value(
          value: getIt<NotificationCubit>()..fetchUnreadCount(),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileCubit>()..getProfileData(),
        ),
      ],

      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) =>
            current is HasActiveShipment || current is NoActiveShipment,
        listener: (context, state) {
          if (_isFirstCheck) {
            _isFirstCheck = false;

            state.maybeWhen(
              hasActiveShipment: (shipment) {
                Navigator.pushNamed(
                  context,
                  Routes.availableDriversScreen,
                  arguments: shipment,
                ).then((_) {
                  if (context.mounted) {
                    context.read<HomeCubit>().checkActiveShipment();
                    context.read<ActiveOrdersCubit>().fetchActiveOrders();
                  }
                });
              },

              orElse: () {},
            );
          }
        },
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
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
      ),
    );
  }
}
