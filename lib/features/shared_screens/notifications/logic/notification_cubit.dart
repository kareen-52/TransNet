import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/notifications/data/repo/notification_repo.dart';
import 'notification_state.dart';

/// Notification cubit.
///
/// OFFLINE RULE (per spec):
///  Callers MUST check ConnectivityHelper.isOnline BEFORE calling
///  fetchRecentNotifications/fetchAllNotifications. The screen and bell
///  icon both guard access — this cubit never receives an offline call.
///
/// Unread count: online → always fetch fresh + cache. Offline → cached count.
class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _repo;
  int  unreadCount  = 0;
  bool isShowingAll = false;
  bool _isFetching  = false;   // guard against concurrent fetches

  NotificationCubit(this._repo) : super(const NotificationState.initial());

  // ── Unread count (bell badge) ───────────────────────────────────────────────

  Future<void> fetchUnreadCount() async {
    if (!ConnectivityHelper.isOnline) return; // serve cached count silently
    final result = await _repo.getNewNotificationsCount();
    if (isClosed) return;
    result.when(
      success: (count) {
        unreadCount = count;
        if (!isClosed) emit(NotificationState.countUpdated(count));
      },
      failure: (_) {},
    );
  }

  // ── Notifications list ──────────────────────────────────────────────────────

  Future<void> fetchRecentNotifications() async {
    if (_isFetching) return;   // prevent parallel calls on rapid navigation
    _isFetching = true;

    if (!isClosed) emit(const NotificationState.loading());
    try {
      final result = await _repo.getNotifications(latest: 0);
      if (isClosed) return;
      result.when(
        success: (notifications) {
          isShowingAll = false;
          if (!isClosed) {
            emit(notifications.isEmpty
                ? const NotificationState.empty()
                : NotificationState.success(notifications));
          }
        },
        failure: (error) {
          if (!isClosed) emit(NotificationState.error(error));
        },
      );
    } finally {
      _isFetching = false;
    }
  }

  Future<void> fetchAllNotifications() async {
    if (_isFetching) return;
    _isFetching = true;

    if (!isClosed) emit(const NotificationState.loading());
    try {
      final result = await _repo.getNotifications(latest: 1);
      if (isClosed) return;
      result.when(
        success: (notifications) {
          isShowingAll = true;
          if (!isClosed) {
            emit(notifications.isEmpty
                ? const NotificationState.empty()
                : NotificationState.success(notifications));
          }
        },
        failure: (error) {
          if (!isClosed) emit(NotificationState.error(error));
        },
      );
    } finally {
      _isFetching = false;
    }
  }
}
