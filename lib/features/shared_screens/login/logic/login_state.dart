import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = Loading;
  

  const factory LoginState.successClient() = SuccessClient;
  const factory LoginState.successDriverFirstTime(String email) = SuccessDriverFirstTime;
  const factory LoginState.successDriverOld() = SuccessDriverOld;

  const factory LoginState.error(ApiErrorModel apiErrorModel) = LoginError;
}