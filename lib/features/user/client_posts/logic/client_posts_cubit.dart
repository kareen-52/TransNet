import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/post_model.dart';
import 'package:graduation_progect/features/user/client_posts/data/repo/client_posts_repo.dart';
import 'package:graduation_progect/features/user/client_posts/logic/client_posts_state.dart';

class ClientPostsCubit extends Cubit<ClientPostsState> {
  final ClientPostsRepo _repo;

  List<PostModel> _currentPosts = [];

  ClientPostsCubit(this._repo) : super(const ClientPostsState.initial());

  Future<void> fetchMyPosts() async {
    if (isClosed) return;
    emit(const ClientPostsState.loading());

    final result = await _repo.getMyPosts();

    if (isClosed) return;

    result.when(
      success: (posts) {
        _currentPosts = List.from(posts);
        if (_currentPosts.isEmpty) {
          emit(const ClientPostsState.empty());
        } else {
          emit(ClientPostsState.success(_currentPosts));
        }
      },
      failure: (error) {
        emit(ClientPostsState.error(error));
      },
    );
  }

  Future<ApiResult> deletePost(int id) async {
    final result = await _repo.deletePost(id);

    result.whenOrNull(
      success: (_) {
        final updatedPosts = List<PostModel>.from(_currentPosts)
          ..removeWhere((post) => post.id == id);

        _currentPosts = updatedPosts;

        if (_currentPosts.isEmpty) {
          emit(const ClientPostsState.empty());
        } else {
          emit(ClientPostsState.success(_currentPosts));
        }
      },
    );

    return result;
  }
}
