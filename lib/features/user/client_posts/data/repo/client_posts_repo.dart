import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import '../models/post_model.dart';

class ClientPostsRepo {
  final ApiService _apiService;

  ClientPostsRepo(this._apiService);

  Future<ApiResult<List<PostModel>>> getMyPosts() async {
    try {
      final response = await _apiService.getClientPosts();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> deletePost(int id) async {
    try {
      final response = await _apiService.deletePost(id);
      return ApiResult.success(response['message'] ?? 'تم حذف الإعلان بنجاح.');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
