import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';

part 'verification_state.freezed.dart';

@freezed
class VerificationState<T> with _$VerificationState<T> {
  const factory VerificationState.initial() = _Initial;
  const factory VerificationState.loading({@Default(false) bool isResending}) = VerificationLoading<T>;
  const factory VerificationState.success(T data, {@Default(false) bool isResending}) = VerificationSuccess<T>;
  const factory VerificationState.error(ApiErrorModel apiErrorModel) = VerificationError<T>;
}