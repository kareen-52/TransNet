import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import '../data/models/post_details_model.dart';

part 'post_details_state.freezed.dart';

@freezed
class PostDetailsState with _$PostDetailsState {
  const factory PostDetailsState.initial() = _Initial;
  const factory PostDetailsState.loading() = _Loading;
  const factory PostDetailsState.success(PostDetailsModel data) = _Success;
  const factory PostDetailsState.error(ApiErrorModel error) = _Error;
}