import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/features/driver/driverReviews/model/review_response.dart';

part 'driver_reviews_state.freezed.dart';

@freezed
class DriverReviewsState with _$DriverReviewsState {
  const factory DriverReviewsState.initial() = _Initial;
  const factory DriverReviewsState.loading() = Loading;
  const factory DriverReviewsState.success(ReviewResponse response) = Success;
  const factory DriverReviewsState.error(ApiErrorModel error) = Error;
}