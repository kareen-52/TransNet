import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/user/active_orders/ui/screen/active_orders_section.dart'; // ← import الجديد
import 'package:graduation_progect/features/user/home_screen/logic/home_cubit.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/shipping_card/shipping_card.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/tracking_card.dart';
import 'package:graduation_progect/features/user/vehicle_types/logic/vehicle_types_cubit.dart';
import 'package:graduation_progect/features/user/vehicle_types/ui/screens/transport_types_section.dart';
import 'package:graduation_progect/features/user/active_orders/logic/active_orders_cubit.dart';

class HomeContent extends StatelessWidget {
  final bool isTablet;
  const HomeContent({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      onRefresh: () async {
        await getIt<HomeCubit>().refreshQuietly();
        // getIt<ActiveOrdersCubit>().fetchActiveOrders();
        getIt<ActiveOrdersCubit>().silentRefresh();
        getIt<VehicleTypesCubit>().fetchVehicleTypes();
        getIt<ProfileCubit>().getProfileData();
        // getIt<NotificationCubit>().fetchUnreadCount();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 56.w : 16.w,
            vertical: isTablet ? 32.h : 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isTablet
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(flex: 2, child: ShippingCard()),
                        horizontalSpace(24),
                        const Expanded(child: TrackingCard()),
                      ],
                    )
                  : const ShippingCard(),

              verticalSpace(isTablet ? 40 : 32),

              const ActiveOrdersSection(),

              verticalSpace(isTablet ? 40 : 32),

              const TransportMethodsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
