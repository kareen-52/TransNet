// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
// import 'package:graduation_progect/core/di/dependency_injection.dart';
// import 'package:graduation_progect/core/widgets/app_text_button.dart';
// import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';
// import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
// import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';
// import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_state.dart';
// import 'package:graduation_progect/features/shared_screens/notifications/ui/screens/notifications_loading_screen.dart';
// import '../widgets/notification_card.dart';

// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // OFFLINE GUARD — per spec: don't open, don't load, don't show retry
//     if (!ConnectivityHelper.isOnline) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('الإشعارات')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.wifi_off_rounded,
//                 size: 64.sp,
//                 color: Theme.of(context).colorScheme.outline,
//               ),
//               SizedBox(height: 16.h),
//               Text(
//                 'لا يوجد اتصال بالإنترنت',
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       color: Theme.of(context).colorScheme.onSurfaceVariant,
//                     ),
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 'تحقق من الاتصال وحاول مرة أخرى',
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Theme.of(context).colorScheme.outline,
//                     ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return BlocProvider.value(
//       value: getIt<NotificationCubit>()..fetchRecentNotifications(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('الإشعارات')),
//         body: BlocBuilder<NotificationCubit, NotificationState>(
//           buildWhen: (_, curr) => curr is! CountUpdated,
//           builder: (context, state) {
//             return state.maybeWhen(
//               loading: () => const NotificationsShimmerLoading(),

//               empty: () => EmptyStateWidget(
//                 title: 'لا يوجد إشعارات',
//                 subTitle: 'لم تتلقَ أي إشعارات حتى الآن.',
//                 onRetry: () =>
//                     context.read<NotificationCubit>().fetchAllNotifications(),
//               ),

//               error: (errorModel) => ErrorStateWidget(
//                 message: errorModel.getAllErrorMessages(),
//                 onRetry: () =>
//                     context.read<NotificationCubit>().fetchAllNotifications(),
//               ),

//               success: (notifications) {
//                 final cubit = context.read<NotificationCubit>();
//                 return Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         padding: EdgeInsets.only(
//                           top: 16.h,
//                           bottom: 48.h,
//                           left: 16.w,
//                           right: 16.w,
//                         ),
//                         itemCount: notifications.length,
//                         itemBuilder: (_, i) =>
//                             NotificationCard(notification: notifications[i]),
//                       ),
//                     ),
//                     if (!cubit.isShowingAll)
//                       Padding(
//                         padding: EdgeInsets.only(
//                           top: 8.h,
//                           bottom: 56.h,
//                           left: 16.w,
//                           right: 16.w,
//                         ),
//                         child: AppTextButton(
//                           onPressed: () => cubit.fetchAllNotifications(),
//                           text: 'عرض جميع الإشعارات',
//                         ),
//                       ),
//                   ],
//                 );
//               },

//               orElse: () => const SizedBox.shrink(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/responsive/responsive_layout.dart';
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
    final bool isTablet = context.isTablet;

    if (!ConnectivityHelper.isOnline) {
      return Scaffold(
        appBar: AppBar(title: const Text('الإشعارات')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 64.sp,
                color: Theme.of(context).colorScheme.outline,
              ),
              SizedBox(height: 16.h),
              Text(
                'لا يوجد اتصال بالإنترنت',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              SizedBox(height: 8.h),
              Text(
                'تحقق من الاتصال وحاول مرة أخرى',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return BlocProvider.value(
      value: getIt<NotificationCubit>()..fetchRecentNotifications(),
      child: Scaffold(
        appBar: AppBar(title: const Text('الإشعارات')),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          buildWhen: (_, curr) => curr is! CountUpdated,
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const NotificationsShimmerLoading(),
              empty: () => EmptyStateWidget(
                title: 'لا يوجد إشعارات',
                subTitle: 'لم تتلقَ أي إشعارات حتى الآن.',
                onRetry: () =>
                    context.read<NotificationCubit>().fetchAllNotifications(),
              ),
              error: (errorModel) => ErrorStateWidget(
                message: errorModel.getAllErrorMessages(),
                onRetry: () =>
                    context.read<NotificationCubit>().fetchAllNotifications(),
              ),
              success: (notifications) {
                final cubit = context.read<NotificationCubit>();

           
                final hPad = isTablet ? 48.w : 16.w;

                return Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isTablet ? 780 : double.infinity,
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                              top: 16.h,
                              bottom: 48.h,
                              left: hPad,
                              right: hPad,
                            ),
                            itemCount: notifications.length,
                            itemBuilder: (_, i) => NotificationCard(
                              notification: notifications[i],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!cubit.isShowingAll)
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.h,
                          bottom: 56.h,
                          left: hPad,
                          right: hPad,
                        ),
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
