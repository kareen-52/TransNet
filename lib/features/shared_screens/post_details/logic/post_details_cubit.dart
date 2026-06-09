import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/post_details/data/models/post_details_model.dart';
import 'package:graduation_progect/features/shared_screens/post_details/data/repo/post_details_repo.dart';
import 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  final PostDetailsRepo _repo;
  PostDetailsModel? currentPostDetails;

  PostDetailsCubit(this._repo) : super(const PostDetailsState.initial());

  Future<void> getPostDetails(int id) async {
    if (isClosed) return;
    emit(const PostDetailsState.loading());

    final result = await _repo.getPostDetails(id);
    if (isClosed) return;

    result.when(
      success: (data) {
        currentPostDetails = data;
        emit(PostDetailsState.success(data));
      },
      failure: (error) => emit(PostDetailsState.error(error)),
    );
  }

  Future<void> acceptDriverOffer(int postId, int driverId) async {
    if (isClosed) return;
    emit(PostDetailsState.acceptLoading(driverId));

    final result = await _repo.acceptDriverOffer(postId, driverId);
    if (isClosed) return;

    result.when(
      success: (msg) => emit(PostDetailsState.acceptSuccess(msg)),
      failure: (error) => emit(PostDetailsState.acceptError(error)),
    );
  }
}