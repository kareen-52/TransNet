import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import '../data/models/post_model.dart';

part 'client_posts_state.freezed.dart';

@freezed
class ClientPostsState with _$ClientPostsState {
  const factory ClientPostsState.initial() = _Initial;
  const factory ClientPostsState.loading() = _Loading;
  const factory ClientPostsState.empty() = _Empty;
  const factory ClientPostsState.success(List<PostModel> posts) = _Success;
  const factory ClientPostsState.error(ApiErrorModel error) = _Error;
}
