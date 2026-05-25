import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/driver_posts/data/repo/driver_posts_repo.dart';

import 'driver_posts_state.dart';

class DriverPostsCubit extends Cubit<DriverPostsState> {
  final DriverPostsRepo _repo;

  DriverPostsCubit(this._repo) : super(const DriverPostsState.initial());

  Future<void> fetchSuitablePosts() async {
    if (isClosed) return;
    emit(const DriverPostsState.loading());

    final result = await _repo.getSuitablePosts();
    
    if (isClosed) return;

    result.when(
      success: (posts) {
        if (posts.isEmpty) {
          emit(const DriverPostsState.empty());
        } else {
          emit(DriverPostsState.success(posts));
        }
      },
      failure: (error) {
        emit(DriverPostsState.error(error));
      },
    );
  }
}