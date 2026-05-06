import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/networking/api_error_model.dart';
import '../data/models/forgot_password_responses.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;

  const factory ForgotPasswordState.loading() = Loading;

  const factory ForgotPasswordState.sendEmailSuccess(
    ForgotPasswordResponse data,
  ) = SendEmailSuccess;

  const factory ForgotPasswordState.verifyCodeSuccess(
    ForgotPasswordResponse data,
  ) = VerifyCodeSuccess;

  const factory ForgotPasswordState.resetPasswordSuccess(
    ForgotPasswordResponse data,
  ) = ResetPasswordSuccess;

  const factory ForgotPasswordState.error(ApiErrorModel apiErrorModel) = Error;
}
