import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/driverReviews/logic/driver_reviews_state.dart';
import 'package:graduation_progect/features/driver/driverReviews/data/repo/driver_reviews_repo.dart';

class DriverReviewsCubit extends Cubit<DriverReviewsState> {
  final DriverReviewsRepo _repo;

  DriverReviewsCubit(this._repo) : super(const DriverReviewsState.initial());

  Future<void> getDriverReviews(int driverId) async {
    emit(const DriverReviewsState.loading());
    final response = await _repo.getDriverReviews(driverId);

    response.when(
      success: (data) => emit(DriverReviewsState.success(data)),
      failure: (error) => emit(DriverReviewsState.error(error)),
    );
  }
}