import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/home/ui/widgets/availability_toggle.dart';
import 'package:graduation_progect/features/driver/home/ui/widgets/challenge_card.dart';
import 'package:graduation_progect/features/driver/home/logic/home_driver_cubit.dart';
import 'package:graduation_progect/features/driver/home/logic/driver_home_state.dart';

import 'package:graduation_progect/features/driver/home/ui/sections/scheduled_orders_section.dart';
import 'package:graduation_progect/features/driver/instant_orders/logic/instant_orders_cubit.dart';
import 'package:graduation_progect/features/driver/instant_orders/ui/screens/instant_orders_section.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';

class HomeContent extends StatelessWidget {
  final bool isTablet;
  const HomeContent({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      buildWhen: (previous, current) {
        return current.maybeWhen(
          initial: () => false,
          availabilityChanged: (_, __) => true,
          shipmentCountLoaded: (_) => true,
          orElse: () => false,
        );
      },
      builder: (context, state) {
        final cubit = context.read<DriverHomeCubit>();
        final isAvailable = cubit.isAvailable;
        final shipmentCount = cubit.shipmentCount;

        return RefreshIndicator(
          color: theme.colorScheme.primary,
          backgroundColor: theme.colorScheme.surface,
          onRefresh: () async {
            await context.read<DriverHomeCubit>().fetchShipmentCountAndStatus();
            context.read<ProfileCubit>().getProfileData();

            if (isAvailable) {
              await context.read<InstantOrdersCubit>().fetchPendingOrders(
                showLoading: false,
              );
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvailabilityToggle(isAvailable: isAvailable),
                verticalSpace(16),

                ChallengeCard(
                  isAvailable: isAvailable,
                  completedShipments: shipmentCount,
                ),

                verticalSpace(32),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  child: isAvailable
                      ? BlocProvider.value(
                          value: getIt<InstantOrdersCubit>()..fetchPendingOrders(),
                          child: const InstantOrdersSection(key: ValueKey('instant'),),
                        )
                      : const ScheduledOrdersSection(key: ValueKey('scheduled'),),
                ),
                verticalSpace(60),
              ],
            ),
          ),
        );
      },
    );
  }
}
