import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/user/client_posts/data/repo/client_posts_repo.dart';
import 'package:graduation_progect/features/user/client_posts/logic/client_posts_state.dart';

class ClientPostsCubit extends Cubit<ClientPostsState> {
  final ClientPostsRepo _repo;

  ClientPostsCubit(this._repo) : super(const ClientPostsState.initial());

  Future<void> fetchMyPosts() async {
    if (isClosed) return;
    emit(const ClientPostsState.loading());

    final result = await _repo.getMyPosts();
    
    if (isClosed) return;


    result.when(
      success: (posts) {
        if (posts.isEmpty) {
          emit(const ClientPostsState.empty());
        } else {
          emit(ClientPostsState.success(posts));
        }
      },
      failure: (error) {
        emit(ClientPostsState.error(error));
      },
    );
  }
}