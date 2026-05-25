import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/post_model.dart';

part 'driver_posts_state.freezed.dart';

@freezed
class DriverPostsState with _$DriverPostsState {
  const factory DriverPostsState.initial() = _Initial;
  const factory DriverPostsState.loading() = _Loading;
  const factory DriverPostsState.empty() = _Empty;
  const factory DriverPostsState.success(List<PostModel> posts) = _Success;
  const factory DriverPostsState.error(ApiErrorModel error) = _Error;
}