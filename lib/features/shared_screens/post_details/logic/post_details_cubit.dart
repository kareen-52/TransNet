import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/post_details/data/repo/post_details_repo.dart';
import 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  final PostDetailsRepo _repo;
  
  PostDetailsCubit(this._repo) : super(const PostDetailsState.initial());

  Future<void> getPostDetails(int id) async {
    if (isClosed) return;
    emit(const PostDetailsState.loading());

    final result = await _repo.getPostDetails(id);
    if (isClosed) return;

    result.when(
      success: (data) => emit(PostDetailsState.success(data)),
      failure: (error) => emit(PostDetailsState.error(error)),
    );
  }
}