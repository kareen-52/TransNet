import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import '../data/models/notification_model.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial()                                     = _Initial;
  const factory NotificationState.loading()                                     = Loading;
  const factory NotificationState.success(List<NotificationModel> notifications) = Success;
  const factory NotificationState.empty()                                       = Empty;
  const factory NotificationState.error(ApiErrorModel error)                    = Error;
  const factory NotificationState.countUpdated(int count)                       = CountUpdated;
}
