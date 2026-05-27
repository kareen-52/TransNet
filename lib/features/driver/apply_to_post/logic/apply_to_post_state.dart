import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';

part 'apply_to_post_state.freezed.dart';

@freezed
class ApplyToPostState with _$ApplyToPostState {
  const factory ApplyToPostState.initial() = _Initial;
  const factory ApplyToPostState.loading() = _Loading;
  const factory ApplyToPostState.success(String message) = _Success;
  const factory ApplyToPostState.error(ApiErrorModel error) = _Error;
}