import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/widgets/icon_button_header.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_state.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!ConnectivityHelper.isOnline) {
          SnackBarHelper.showError(
            context,
            'لا يوجد اتصال بالإنترنت',
          );
          return;
        }

        Navigator.pushNamed(context, Routes.getAllNotifications).then((_) {
          if (context.mounted) {
            context.read<NotificationCubit>().fetchUnreadCount();
          }
        });
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        clipBehavior: Clip.none,
        children: [
          const IconButtonHeader(icon: Icons.notifications_none_rounded),

          BlocBuilder<NotificationCubit, NotificationState>(
            buildWhen: (prev, curr) => curr is CountUpdated,
            builder: (context, state) {
              final count = context.read<NotificationCubit>().unreadCount;
              if (count <= 0) return const SizedBox.shrink();

              return Positioned(
                top: -2.h,
                right: -2.w,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count > 99 ? '99+' : count.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
