import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/post_model.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/governorate_model.dart';

part 'create_post_state.freezed.dart';

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState.initial() = _Initial;
  const factory CreatePostState.loading() = _Loading;


  const factory CreatePostState.govLoading() = _GovLoading;
  const factory CreatePostState.govSuccess(List<GovernorateModel> govs) =
      _GovSuccess;
  const factory CreatePostState.govError(ApiErrorModel error) = _GovError;


  const factory CreatePostState.uiUpdated(int timestamp) = _UiUpdated;


  const factory CreatePostState.stepOneSuccess(PostModel post, String message) =
      _StepOneSuccess;
  const factory CreatePostState.stepTwoSuccess(String message) =
      _StepTwoSuccess;
  const factory CreatePostState.submitError(ApiErrorModel error) = _SubmitError;

  const factory CreatePostState.stepTwoLoading() = _StepTwoLoading;
  const factory CreatePostState.stepTwoError(ApiErrorModel error) =
      _StepTwoError;
}
