import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/home/logic/home_driver_cubit.dart';
import 'package:graduation_progect/features/driver/home/logic/driver_home_state.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/appbar/notification_icon.dart';

class DriverHeader extends StatelessWidget {
  final String driverName;
  final int driverId;

  const DriverHeader({
    super.key,
    required this.driverName,
    required this.driverId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      builder: (context, state) {
        final cubit = context.read<DriverHomeCubit>();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 60.r,
                    height: 60.r,
                    // color: theme.colorScheme.surface,
                    child: Image.asset(
                      'assets/icons/app_icon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  horizontalSpace(8),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          'مرحباً $driverName',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),

                      if (cubit.shipmentCount > 0)
                        Flexible(
                          child: Text(
                            '${cubit.shipmentCount} شحنات متتالية🔥',
                            style: textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              // fontSize: 12.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),

              const NotificationIcon(),

              // Container(
              //   padding: EdgeInsets.all(8.w),
              //   decoration: BoxDecoration(
              //     color: theme.colorScheme.surface,
              //     shape: BoxShape.circle,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.05),
              //         blurRadius: 6,
              //       ),
              //     ],
              //   ),
              //   child: Icon(
              //     Icons.notifications_none_outlined,
              //     size: 24.sp,
              //     color: theme.colorScheme.onSurface,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
