import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/user/review_driver/data/repo/review_driver_repo.dart';
import 'review_driver_state.dart';

class ReviewDriverCubit extends Cubit<ReviewDriverState> {
  final ReviewDriverRepo _repo;
  ReviewDriverCubit(this._repo) : super(const ReviewDriverState.initial());

  Future<void> submitReview(int driverId, double rate, String review) async {
    if (rate < 1) {
      emit(const ReviewDriverState.error("يرجى اختيار عدد النجوم للتقييم"));
      return;
    }
    if (review.trim().isEmpty) {
      emit(const ReviewDriverState.error("يرجى كتابة وصف للتقييم"));
      return;
    }

    emit(const ReviewDriverState.loading());
    final result = await _repo.createReview(driverId: driverId, rate: rate, review: review);

    result.when(
      success: (msg) => emit(ReviewDriverState.success(msg)),
      failure: (error) => emit(ReviewDriverState.error(error.getAllErrorMessages())),
    );
  }
}