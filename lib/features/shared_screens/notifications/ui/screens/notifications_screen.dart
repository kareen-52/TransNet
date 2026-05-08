import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_state.dart';
import 'package:graduation_progect/features/shared_screens/notifications/ui/screens/notifications_loading_screen.dart';
import '../widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<NotificationCubit>()..fetchRecentNotifications(),
      // create: (context) => getIt<NotificationCubit>()..fetchAllNotifications(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الإشعارات'),
          // centerTitle: true,
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          buildWhen: (previous, current) => current is! CountUpdated,
          builder: (context, state) {
            return state.maybeWhen(

              loading: () => const NotificationsShimmerLoading(),
              

              empty: () => EmptyStateWidget(
                title: 'لا يوجد إشعارات',
                subTitle: 'لم تتلقَ أي إشعارات جديدة حتى الآن.',
                onRetry: () {
                  context.read<NotificationCubit>().fetchAllNotifications();
                 },
              ),


              error: (errorModel) => ErrorStateWidget(
                message: errorModel.getAllErrorMessages(),
                onRetry: () => context.read<NotificationCubit>().fetchAllNotifications(),
              ),


              success: (notifications) {
                final cubit = context.read<NotificationCubit>();
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 16.w, bottom: 48.w, left: 16.h, right: 16.h),
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return NotificationCard(notification: notifications[index]);
                        },
                      ),
                    ),
                    if (!cubit.isShowingAll)
                      Padding(
                        padding: EdgeInsets.only(top: 16.w, bottom: 56.w, left: 16.h, right: 16.h),
                        child: AppTextButton(
                          onPressed: () => cubit.fetchAllNotifications(),
                           text: 'عرض جميع الإشعارات',
                        ),
                      ),
                  ],
                );
              },

              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}