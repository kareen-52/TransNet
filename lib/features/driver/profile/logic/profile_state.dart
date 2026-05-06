import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';

part 'profile_state.freezed.dart';
@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = Loading;
  const factory ProfileState.success(ProfileResponse profileResponse) = Success;
  const factory ProfileState.editSuccess(String message) = EditSuccess;
  const factory ProfileState.error(ApiErrorModel apiErrorModel) = Error;
}