import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/driver_posts/logic/driver_posts_cubit.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/post_model.dart';
import '../data/repos/driver_applied_posts_repo.dart';
import 'driver_applied_posts_state.dart';

class DriverAppliedPostsCubit extends Cubit<DriverAppliedPostsState> {
  final DriverAppliedPostsRepo _repo;
  List<PostModel> _currentPosts = [];

  DriverAppliedPostsCubit(this._repo) : super(const DriverAppliedPostsState.initial());

  Future<void> fetchAppliedPosts() async {
    if (isClosed) return;
    emit(const DriverAppliedPostsState.loading());

    final result = await _repo.getAppliedPosts();
    
    if (isClosed) return;

    result.when(
      success: (posts) {
        _currentPosts = List.from(posts);
        if (_currentPosts.isEmpty) {
          emit(const DriverAppliedPostsState.empty());
        } else {
          emit(DriverAppliedPostsState.success(_currentPosts));
        }
      },
      failure: (error) {
        emit(DriverAppliedPostsState.error(error));
      },
    );
  }

  Future<ApiResult<String>> cancelOffer(int postId) async {
    final result = await _repo.cancelOffer(postId);

    result.whenOrNull(
      success: (_) {
        _currentPosts.removeWhere((post) => post.id == postId);
        emit(const DriverAppliedPostsState.loading());
        if (_currentPosts.isEmpty) {
          emit(const DriverAppliedPostsState.empty());
        } else {
          emit(DriverAppliedPostsState.success(List.from(_currentPosts)));
        }
        try {
          getIt<DriverPostsCubit>().fetchSuitablePosts();
        } catch (_) {}
      },
    );

    return result;
  }
}