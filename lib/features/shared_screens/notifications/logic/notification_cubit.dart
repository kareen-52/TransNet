import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/notifications/data/repo/notification_repo.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _repo;
  int unreadCount = 0;

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
        // في حال فشل جلب العدد (مثلاً نت ضعيف)، نتجاهل بصمت كي لا نزعج المستخدم في الرئيسية
      },
    );
  }


  void fetchAllNotifications() async {
    emit(const NotificationState.loading());
    final result = await _repo.getAllNotifications();
    if (isClosed) return;

    result.when(
      success: (notifications) {

        unreadCount = 0; 
        
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