import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/profile_nav_item.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/profile_section_container.dart';

class NotificationsSection extends StatelessWidget {
  const NotificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الإشعارات',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12.h),

        ProfileSectionContainer(
          children: [
            ProfileNavItem(
              title: 'الإشعارات',
              icon: Icons.notifications_none_outlined,
              // badge: context.read<NotificationCubit>().unreadCount,
              onTap: () {
                // Navigator.pushNamed(context, Routes.getAllNotifications);
                Navigator.pushNamed(context, Routes.getAllNotifications).then((_) {
                  if (context.mounted) context.read<NotificationCubit>().fetchUnreadCount();
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
