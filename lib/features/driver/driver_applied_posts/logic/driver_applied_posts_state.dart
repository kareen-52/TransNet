import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/post_model.dart';

part 'driver_applied_posts_state.freezed.dart';

@freezed
class DriverAppliedPostsState with _$DriverAppliedPostsState {
  const factory DriverAppliedPostsState.initial() = _Initial;
  const factory DriverAppliedPostsState.loading() = _Loading;
  const factory DriverAppliedPostsState.empty() = _Empty;
  const factory DriverAppliedPostsState.success(List<PostModel> posts) = _Success;
  const factory DriverAppliedPostsState.error(ApiErrorModel error) = _Error;
}