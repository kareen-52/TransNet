import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/client_post_model.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/governorate_model.dart';

part 'create_post_state.freezed.dart';

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState.initial() = _Initial;
  const factory CreatePostState.loading() = _Loading;
  
  // لجلب المحافظات
  const factory CreatePostState.govLoading() = _GovLoading;
  const factory CreatePostState.govSuccess(List<GovernorateModel> govs) = _GovSuccess;
  const factory CreatePostState.govError(ApiErrorModel error) = _GovError;

  // لتحديث الواجهة عند التنقل بين الخطوات
  const factory CreatePostState.uiUpdated(int timestamp) = _UiUpdated;

  // حالات الإرسال
  const factory CreatePostState.stepOneSuccess(ClientPostModel post, String message) = _StepOneSuccess;
  const factory CreatePostState.stepTwoSuccess(String message) = _StepTwoSuccess;
  const factory CreatePostState.submitError(ApiErrorModel error) = _SubmitError;

  const factory CreatePostState.stepTwoLoading() = _StepTwoLoading;
  const factory CreatePostState.stepTwoError(ApiErrorModel error) = _StepTwoError;
}