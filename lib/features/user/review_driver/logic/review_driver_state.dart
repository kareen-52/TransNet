import 'package:freezed_annotation/freezed_annotation.dart';
part 'review_driver_state.freezed.dart';

@freezed
class ReviewDriverState with _$ReviewDriverState {
  const factory ReviewDriverState.initial() = _Initial;
  const factory ReviewDriverState.loading() = _Loading;
  const factory ReviewDriverState.success(String message) = _Success;
  const factory ReviewDriverState.error(String error) = _Error;
}