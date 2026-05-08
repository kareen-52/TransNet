import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/notifications/data/repo/notification_repo.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _repo;
  int unreadCount = 0;
  bool isShowingAll = false;

  NotificationCubit(this._repo) : super(const NotificationState.initial());


  void fetchUnreadCount() async {
    final result = await _repo.getNewNotificationsCount();
    if (isClosed) return;

    result.when(
      success: (count) {
        unreadCount = count;
        emit(NotificationState.countUpdated(count));
      },
      failure: (error) {
      },
    );
  }

  Future<void> fetchRecentNotifications() async {
    emit(const NotificationState.loading());
    final result = await _repo.getNotifications(latest: 0);
    if (isClosed) return;

    result.when(
      success: (notifications) {
        isShowingAll = false;
        if (notifications.isEmpty) {
          emit(const NotificationState.empty());
        } else {
          emit(NotificationState.success(notifications));
        }
      },
      failure: (error) => emit(NotificationState.error(error)),
    );
  }

  Future<void> fetchAllNotifications() async {
    emit(const NotificationState.loading());
    final result = await _repo.getNotifications(latest: 1);
    if (isClosed) return;

    result.when(
      success: (notifications) {
        isShowingAll = true;
        if (notifications.isEmpty) {
          emit(const NotificationState.empty());
        } else {
          emit(NotificationState.success(notifications));
        }
      },
      failure: (error) => emit(NotificationState.error(error)),
    );
  }

}