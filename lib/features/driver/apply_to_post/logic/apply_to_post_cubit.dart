import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/apply_to_post/data/repo/apply_to_post_repo.dart';
import 'apply_to_post_state.dart';

class ApplyToPostCubit extends Cubit<ApplyToPostState> {
  final ApplyToPostRepo _repo;
  ApplyToPostCubit(this._repo) : super(const ApplyToPostState.initial());

  Future<void> submitApplication(int postId, double price, String date) async { 
    if (isClosed) return;
    emit(const ApplyToPostState.loading());
    
    final result = await _repo.applyToPost(postId: postId, price: price, date: date);

    if (isClosed) return;
    result.when(
      success: (msg) => emit(ApplyToPostState.success(msg)),
      failure: (err) => emit(ApplyToPostState.error(err)),
    );
  }
}