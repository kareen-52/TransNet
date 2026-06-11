import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/post_model.dart';

class DriverAppliedPostsRepo {
  final ApiService _apiService;

  DriverAppliedPostsRepo(this._apiService);

  Future<ApiResult<List<PostModel>>> getAppliedPosts() async {
    try {
      final response = await _apiService.getAppliedPostsDriver();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> cancelOffer(int postId) async {
    try {
      final response = await _apiService.cancelPostDriver(postId);
      return ApiResult.success(response['message'] ?? 'تم إلغاء عرضك بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}