import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';

part 'client_profile_state.freezed.dart';

@freezed
class ClientProfileState with _$ClientProfileState {
  const factory ClientProfileState.initial()                                = _Initial;
  const factory ClientProfileState.loading()                                = _Loading;
  const factory ClientProfileState.success(ProfileResponse profileResponse) = _Success;
  const factory ClientProfileState.editSuccess(String message)              = _EditSuccess;
  const factory ClientProfileState.error(ApiErrorModel apiErrorModel)       = _Error;
}
